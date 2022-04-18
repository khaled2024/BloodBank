//
//  DetailsCellViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/03/2022.
//

import UIKit

struct Comment {
    let title: String
    let subTitle: String?
}

class DetailsCellViewController: UIViewController, UISheetPresentationControllerDelegate  {
    //MARK: - variabels
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var addCommentView: UIView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var insideShareBtn: UIButton!
    @IBOutlet weak var insidelikedBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var descriptionDetailLbl: UILabel!
    @IBOutlet weak var timeDetailLbl: UILabel!
    @IBOutlet weak var addressDetailLbl: UILabel!
    @IBOutlet weak var bloodTypeDetailLbl: UILabel!
    @IBOutlet weak var donorImageDetail: UIImageView!
    @IBOutlet weak var patientDetailLbl: UILabel!
    let customBtn = UserCustomBtn()
    @IBOutlet weak var sharingBtn: UIButton!
    var myPatient: Patient!
    let customView = CustomView()
    let comment = [Comment(title: "عمرو", subTitle: "i can help you in this blood request send me all details i can help you in this blood request send me all details i can help you in this blood request send me all details"),Comment(title: "خالد", subTitle: "i can help you in this blood request send me all details"),Comment(title: "Amr", subTitle: "i can help you in this blood request send me all details i can help you in this blood request send me all details"),Comment(title: "khaled", subTitle: "i can help you in this blood request send me all details"),Comment(title: "Amr", subTitle: "i can help you in this blood request send me all details")]
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSheetPresentation()
        setUpData()
        setUpBlurandCommentView()
        self.likeBtn.customTitleLbl(btn: likeBtn, text: "اعجبني", fontSize: 13)
        self.commentBtn.customTitleLbl(btn: commentBtn, text: "تعليق", fontSize: 13)
        self.shareBtn.customTitleLbl(btn: shareBtn, text: "مشاركه", fontSize: 13)
    }
    
    //MARK: - Private func
    private func setUpBlurandCommentView(){
        // blurView & size
        blurView.bounds = self.view.bounds
        //set add story view 90% of width & 45% of height
        addCommentView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
    }
    private func setUpDesign(){
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
        customView.customView(theView: addCommentView)
    }
    private func setUpSheetPresentation(){
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .large
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    private func setUpData(){
        patientDetailLbl.text = myPatient.name
        bloodTypeDetailLbl.text = myPatient.bloodType
        addressDetailLbl.text = myPatient.address
        timeDetailLbl.text = myPatient.time
        descriptionDetailLbl.text = myPatient.description
        donorImageDetail.load(urlString: myPatient.donorImage!)
    }
    private func shareContent(){
        let activityController: UIActivityViewController
        let defaultText = "Hello \(patientDetailLbl.text!),I see you need a \(bloodTypeDetailLbl.text!) group, i Can help you Call me."
        let image = UIImage(named: "blood-donation")
        activityController = UIActivityViewController(activityItems: [defaultText , image!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
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
    
    //MARK: - Actions
    @IBAction func closeCommentView(_ sender: UIButton) {
        self.animateOut(desireView: blurView)
        self.animateOut(desireView: addCommentView)
    }
    @IBAction func postCommentBtnTapped(_ sender: UIButton) {
        if let comment = commentTextView.text , !comment.isEmpty{
            print(comment)
            self.animateOut(desireView: blurView)
            self.animateOut(desireView: addCommentView)
            commentTextView.text = ""
        }else{
            showNormalAlert(title: "Sorry", message: "Please write a Comment.")
        }
    }
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        if sender == sharingBtn{
            shareContent()
        }else{
            print("shared")
            customBtn.toggleBtnByForground(Btn: insideShareBtn)
            shareContent()
        }
    }
    @IBAction func commentBtnTapped(_ sender: UIButton) {
        print("commented")
        self.animateIn(desireView: blurView)
        self.animateIn(desireView: addCommentView)
        
        
    }
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        print("liked")
        customBtn.toggleBtnByForground(Btn: insidelikedBtn)
    }
    @IBAction func blurScreenTapped(_ sender: UITapGestureRecognizer) {
        animateOut(desireView: addCommentView)
        animateOut(desireView: blurView)
    }
    
}
//MARK: - Extension UITableViewDelegate,UITableViewDataSource
extension DetailsCellViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = comment[indexPath.row].title
        cell.detailTextLabel?.text = comment[indexPath.row].subTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
