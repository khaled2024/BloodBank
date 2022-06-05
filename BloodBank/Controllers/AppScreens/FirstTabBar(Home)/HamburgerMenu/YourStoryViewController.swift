//
//  YourStoryViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 03/04/2022.
//

import UIKit

class YourStoryViewController: UIViewController {
    
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var updateStoryLbl: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var craeteStoryLbl: UILabel!
    @IBOutlet weak var noStoryToShown: UILabel!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var updateTextViewContext: UITextView!
    @IBOutlet weak var storySegmentControll: UISegmentedControl!
    @IBOutlet weak var storyDescription: UITextView!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var addStoryView: UIView!
    @IBOutlet var updateStoryView: UIView!
    @IBOutlet weak var tableView: UITableView!
    let navBar = NavigationBar()
    let customView = CustomView()
    let floatingBtn = FloatinBtn()
    var indexCell: IndexPath = []
    let refreshControll = UIRefreshControl()
    let def = UserDefaults.standard
    var segmentSender = 0
    var p_ssn = ""
    var arrOfPrivateStory: [StoryData] = [StoryData]()
    var storiesArr:[StoryData] = [StoryData]()
    var idOfStory = ""
    //MARK: - AppCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = user[0]
        }
               
        self.getAllStory()
        self.getPrivateStory()
        setUp()
        refreshControll.tintColor = .systemPink
        refreshControll.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.addSubview(refreshControll)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
        self.noStoryToShown.text = "NoStories".Localized()
        self.craeteStoryLbl.text = "Create Story".Localized()
        self.updateStoryLbl.text = "Update Story".Localized()
        self.createBtn.customTitleLbl(btn: createBtn, text: "Create", fontSize: 18)
        self.updateBtn.customTitleLbl(btn: updateBtn, text: "Update", fontSize: 18)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpFloatingBtn()
    }
    //MARK: - private functions
    @objc func reloadData(){
        self.getAllStory()
        getPrivateStory()
        if self.segmentSender == 0 && self.arrOfPrivateStory.count == 0{
            self.tableView.isHidden = true
            self.noDataImage.isHidden = false
            tableView.reloadData()
        }else if self.segmentSender == 0 && self.arrOfPrivateStory.count != 0{
            self.tableView.isHidden = false
            self.noDataImage.isHidden = true
            tableView.reloadData()
        }
        refreshControll.endRefreshing()
    }
    private func addNewStory(){
        tableView.beginUpdates()
        ApiService.sharedService.addStory(content: storyDescription.text, p_ssn: self.p_ssn)
        tableView.endUpdates()
    }
    private func setUp(){
        registerCell()
        setUpBlurandStoryView()
    }
    private func getAllStory(){
        ApiService.sharedService.getStories { error, story in
            if let error = error {
                print(error.localizedDescription)
                self.showNormalAlert(title: "للاسف", message: "لا يمكن الاتصال بالخادم")
                self.tableView.isHidden = true
                self.noStoryToShown.isHidden = true
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "someThinfWrong2")
            }else if let story = story {
                self.tableView.isHidden = false
                self.noStoryToShown.isHidden = true
                self.noDataImage.isHidden = true
                self.storiesArr = story
            }
            if self.storiesArr.count == 0{
                self.tableView.isHidden = true
                self.noStoryToShown.isHidden = false
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "emptyPage-2")
                self.showNormalAlert(title: "للاسف", message: "NoStories".Localized())
            }else{
                self.tableView.reloadData()
            }
        }
    }
    private func setUpBlurandStoryView(){
        // blurView & size
        blurView.bounds = self.view.bounds
        //set add story view 90% of width & 45% of height
        addStoryView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
        updateStoryView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
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
        storySegmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)!], for: .normal)
        storySegmentControll.setTitle("General".Localized(), forSegmentAt: 0)
        storySegmentControll.setTitle("Private".Localized(), forSegmentAt: 1)

        customView.customView(theView: self.addStoryView)
        customView.customView(theView: self.updateStoryView)
        self.noStoryToShown.isHidden = true
        self.noDataImage.isHidden = true
        
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
    //get data of story:>
    private func getPrivateStory(){
        ApiService.sharedService.getStories { error, story in
            self.arrOfPrivateStory = []
            if let error = error {
                print(error.localizedDescription)
            }else if let story = story {
                for story in story {
                    if self.p_ssn == story.p_ssn{
                        self.arrOfPrivateStory.append(story)
                    }
                    print(self.arrOfPrivateStory)
                    self.tableView.reloadData()
                }
            }
        }
    }
    private func setUpSegment(){
        let segmentIndex = self.storySegmentControll.selectedSegmentIndex
        switch segmentIndex{
        case 0:
            if self.storiesArr.count == 0{
                self.tableView.isHidden = true
                self.noStoryToShown.isHidden = false
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "emptyPage-2")
            }else{
                self.tableView.isHidden = false
                self.noStoryToShown.isHidden = true
                self.noDataImage.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                tableView.reloadData()
            }
            
        case 1:
            if self.arrOfPrivateStory.count == 0{
//                self.showNormalAlert(title: "للاسف", message: "انت لم تكتب قصه لك حتي الآن ، اضغط علي انشاء لتتمكن من انشاء قصه ")
                self.tableView.isHidden = true
                self.noStoryToShown.isHidden = false
                self.noDataImage.isHidden = false
                self.noDataImage.image = UIImage(named: "emptyPage-2")
            }else{
                self.tableView.isHidden = false
                self.noStoryToShown.isHidden = true
                self.noDataImage.isHidden = true
                print(segmentIndex)
                self.segmentSender = segmentIndex
                tableView.reloadData()
            }
            
        default:
            break
        }
    }
    private func deleteStory(){
        ApiService.sharedService.deleteStoryData(id: self.idOfStory)
    }
    private func updateStory(){
        ApiService.sharedService.updateData(id: self.idOfStory, content: self.updateTextViewContext.text)
    }
    //MARK: - Action
    @IBAction func segmentControllTapped(_ sender: UISegmentedControl) {
        setUpSegment()
    }
    @IBAction func closeViewBtnTapped(_ sender: UIButton) {
        self.animateOut(desireView: blurView)
        self.animateOut(desireView: addStoryView)
        self.animateOut(desireView: updateStoryView)
    }
    @IBAction func createStoryBtnTapped(_ sender: UIButton) {
        if let storyText = storyDescription.text , !storyText.isEmpty{
            self.addNewStory()
            self.tableView.isHidden = false
            self.noStoryToShown.isHidden = true
            self.segmentSender = self.storySegmentControll.selectedSegmentIndex
            self.storySegmentControll.selectedSegmentIndex = segmentSender
            self.noDataImage.isHidden = true
            if self.segmentSender == 0 {
                tableView.beginUpdates()
                self.getAllStory()
                tableView.reloadData()
                tableView.endUpdates()
            }else{
                tableView.beginUpdates()
                self.getPrivateStory()
                tableView.reloadData()
                tableView.endUpdates()
            }
            self.animateOut(desireView: blurView)
            self.animateOut(desireView: addStoryView)
        }
    }
    @IBAction func updateStoryBtnTapped(_ sender: UIButton) {
        tableView.beginUpdates()
        self.updateStory()
        tableView.endUpdates()
        self.animateOut(desireView: updateStoryView)
        self.animateOut(desireView: blurView)
    }
    @IBAction func BlurScreenTapped(_ sender: UITapGestureRecognizer) {
        animateOut(desireView: blurView)
        animateOut(desireView: addStoryView)
    }
}
//MARK: - extension UITableViewDelegate
extension YourStoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.segmentSender == 0{
            return storiesArr.count
        }else{
            return arrOfPrivateStory.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  self.segmentSender == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourStoryTableViewCell", for: indexPath)as! YourStoryTableViewCell
            cell.config(image: UIImage(named: "donorLogo")!, donorName: "\(storiesArr[indexPath.row].first_name) \(storiesArr[indexPath.row].last_name)", description: storiesArr[indexPath.row].content)
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourStoryTableViewCell", for: indexPath)as! YourStoryTableViewCell
            cell.config(image: UIImage(named: "donorLogo")!, donorName: "\(arrOfPrivateStory[indexPath.row].first_name) \(arrOfPrivateStory[indexPath.row].last_name)", description: arrOfPrivateStory[indexPath.row].content)
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if self.segmentSender == 1 {
            self.idOfStory = arrOfPrivateStory[indexPath.row].id
            let deleteAction = UIContextualAction(style: .normal, title: "Delete".Localized()) { action, view, completionHandeler in
                self.deleteStory()
                self.arrOfPrivateStory.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                if self.arrOfPrivateStory.count == 0{
                    self.tableView.isHidden = true
                    self.noStoryToShown.isHidden = false
                    self.noDataImage.isHidden = false
                }
                tableView.endUpdates()
                completionHandeler(true)
            }
            let updateAction = UIContextualAction(style: .normal, title: "Update".Localized()) { action, view, completioHandeler in
                self.animateIn(desireView: self.blurView)
                self.animateIn(desireView: self.updateStoryView)
                completioHandeler(true)
            }
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            updateAction.image = UIImage(systemName: "pencil")
            updateAction.backgroundColor = .systemGray
            return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
        }else{
            print("cant swipe here")
        }
        return UISwipeActionsConfiguration()
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
