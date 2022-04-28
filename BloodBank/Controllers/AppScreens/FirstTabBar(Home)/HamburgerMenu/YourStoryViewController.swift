//
//  YourStoryViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 03/04/2022.
//

import UIKit

class YourStoryViewController: UIViewController {
    
    @IBOutlet weak var storyDescription: UITextView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var addStoryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let navBar = NavigationBar()
    let customView = CustomView()
    let floatingBtn = FloatinBtn()
    var indexCell: IndexPath = []
    let refreshControll = UIRefreshControl()
    let def = UserDefaults.standard
//    var user: [String] = [String]()
    
    var storiesArr:[StoryData] = [StoryData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        refreshControll.tintColor = .systemPink
        refreshControll.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.addSubview(refreshControll)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpFloatingBtn()
        
    }
    //MARK: - private functions
    @objc func reloadData(){
        self.getAllStory()
        refreshControll.endRefreshing()
        self.tableView.reloadData()
    }
    private func addNewStory(){
        if let user = def.object(forKey: "userInfo")as? [String]{
            print(user)
            ApiService.sharedService.addStory(content: storyDescription.text, p_ssn: "\(user[0])")
        }
    }
    
    private func setUp(){
        getAllStory()
        registerCell()
        setUpBlurandStoryView()
    }
    private func getAllStory(){
        ApiService.sharedService.getStories { error, story in
            if let error = error {
                print(error.localizedDescription)
            }else if let story = story {
                self.storiesArr = story
                
            }
            self.tableView.reloadData()
        }
    }
    private func setUpBlurandStoryView(){
        // blurView & size
        blurView.bounds = self.view.bounds
        //set add story view 90% of width & 45% of height
        addStoryView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
    }
    private func setUpFloatingBtn(){
        floatingBtn.floatingBtn.frame = CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 150, width: 60, height: 60)
        floatingBtn.floatingBtn.addTarget(self, action: #selector(addStoryBtnTapped), for: .touchUpInside)
    }
    
    @objc func addStoryBtnTapped(){
        print("add story tapped")
        self.animateIn(desireView: blurView)
        self.animateIn(desireView: addStoryView)
        
    }
    private func registerCell(){
        tableView.register(UINib(nibName: "YourStoryTableViewCell", bundle: .main), forCellReuseIdentifier: "YourStoryTableViewCell")
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Your Story".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        view.addSubview(floatingBtn.floatingBtn)
        customView.customView(theView: self.addStoryView)
        
    }
    // for blur & add story view
    func animateIn(desireView: UIView){
        let backgroundView = self.view!
        backgroundView.addSubview(desireView)
        //set the view scalling 120%
        desireView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desireView.alpha = 0
        desireView.center = backgroundView.center
        // animate the effect
        UIView.animate(withDuration: 0.3) {
            desireView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desireView.alpha = 1
        }
    }
    func animateOut(desireView: UIView){
        UIView.animate(withDuration: 0.3) {
            desireView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desireView.alpha = 0
        } completion: { _ in
            desireView.removeFromSuperview()
        }
    }
    //MARK: - Action
    @IBAction func closeViewBtnTapped(_ sender: UIButton) {
        self.animateOut(desireView: blurView)
        self.animateOut(desireView: addStoryView)
        
    }
    @IBAction func createStoryBtnTapped(_ sender: UIButton) {
        if let storyText = storyDescription.text , !storyText.isEmpty{
            self.addNewStory()
            self.animateOut(desireView: blurView)
            self.animateOut(desireView: addStoryView)
            
        }
    }
    @IBAction func BlurScreenTapped(_ sender: UITapGestureRecognizer) {
        animateOut(desireView: blurView)
        animateOut(desireView: addStoryView)
    }
}
//MARK: - extension UITableViewDelegate
extension YourStoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storiesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourStoryTableViewCell", for: indexPath)as! YourStoryTableViewCell
        cell.config(image: UIImage(named: "donorLogo")!, donorName: "\(storiesArr[indexPath.row].first_name) \(storiesArr[indexPath.row].last_name)", description: storiesArr[indexPath.row].content)
        cell.selectionStyle = .none
        return cell
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
