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
    let storyArr = [Story(donorName: "خالد حسين خليفه", description: "تخدم الدم لجميع أنواع الأغراض. السرطان (عمليات نقل الدم أثناء العلاج الكيميائي) والجراحة والصدمات وثلاثة أسباب شائعة للتبرع بالدم. تستخدم التبرعات بالدم الكامل في غالبية العلاجات الطبية ، وبعضها لا يتطلب سوى جمع البلازما أو الصفائح الدموية واستخدامها. بشكل عام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما", donorImage: UIImage(named: "donorLogo")!) , Story(donorName: "عمرو حسين خليفه", description: "ام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما والصفائح الدمو", donorImage: UIImage(named: "thankYou")!),Story(donorName: "خالد حسين خليفه", description: "تخدم الدم لجميع أنواع الأغراض. السرطان (عمليات نقل الدم أثناء العلاج الكيميائي) والجراحة والصدمات وثلاثة أسباب شائعة للتبرع بالدم. تستخدم التبرعات بالدم الكامل في غالبية العلاجات الطبية ، وبعضها لا يتطلب سوى جمع البلازما أو الصفائح الدموية واستخدامها. بشكل عام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما", donorImage: UIImage(named: "donorLogo")!) , Story(donorName: "عمرو حسين خليفه", description: "ام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما والصفائح الدمو", donorImage: UIImage(named: "thankYou")!),Story(donorName: "خالد حسين خليفه", description: "تخدم الدم لجميع أنواع الأغراض. السرطان (عمليات نقل الدم أثناء العلاج الكيميائي) والجراحة والصدمات وثلاثة أسباب شائعة للتبرع بالدم. تستخدم التبرعات بالدم الكامل في غالبية العلاجات الطبية ، وبعضها لا يتطلب سوى جمع البلازما أو الصفائح الدموية واستخدامها. بشكل عام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما", donorImage: UIImage(named: "donorLogo")!) , Story(donorName: "عمرو حسين خليفه", description: "ام ، يتطلب 22 علاجًا طبيًا التبرع بالدم. عندما تتبرع بالدم ، عادة ما تقوم منظمات مثل الصليب الأحمر بفصل الدم الكامل إلى خلايا الدم الحمراء والبلازما والصفائح الدمو", donorImage: UIImage(named: "thankYou")!)]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setUpFloatingBtn()
        
    }
    //MARK: - private functions
    private func setUp(){
        registerCell()
        setUpBlurandStoryView()
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
    @IBAction func closeViewBtnTapped(_ sender: UIButton) {
        self.animateOut(desireView: blurView)
        self.animateOut(desireView: addStoryView)
        
    }
    @IBAction func createStoryBtnTapped(_ sender: UIButton) {
        if let storyText = storyDescription.text , !storyText.isEmpty{
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
        return storyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourStoryTableViewCell", for: indexPath)as! YourStoryTableViewCell
        cell.config(image: storyArr[indexPath.row].donorImage, donorName: storyArr[indexPath.row].donorName, description: storyArr[indexPath.row].description)
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
