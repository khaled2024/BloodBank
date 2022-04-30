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
    
    @IBOutlet weak var descriptionDetailLbl: UILabel!
    @IBOutlet weak var timeDetailLbl: UILabel!
    @IBOutlet weak var addressDetailLbl: UILabel!
    @IBOutlet weak var bloodTypeDetailLbl: UILabel!
    @IBOutlet weak var donorImageDetail: UIImageView!
    @IBOutlet weak var patientDetailLbl: UILabel!
    // custom Btn
    @IBOutlet weak var insideBookMarkBtn: UIButton!
    @IBOutlet weak var bookMarkBtn: UIButton!
    @IBOutlet weak var insideAcceptRequestBtn: UIButton!
    @IBOutlet weak var acceptRequestBtn: UIButton!
    @IBOutlet weak var volunteeringBtn: UIButton!
    @IBOutlet weak var insidevolunteeringBtn: UIButton!
    
    let customBtn = UserCustomBtn()
    @IBOutlet weak var sharingBtn: UIButton!
    var myPatient: Patient!
    let customView = CustomView()
    let def = UserDefaults.standard
    var arrOfQuickRequestDetail: QuickRequestData!
    
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
    }
    override func viewDidAppear(_ animated: Bool) {
        setBookMark()
        
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
        self.acceptRequestBtn.customTitleLbl(btn: acceptRequestBtn, text: "تلبيه الطلب", fontSize: 13)
        self.volunteeringBtn.customTitleLbl(btn: volunteeringBtn, text: "تطوع", fontSize: 13)
        self.bookMarkBtn.customTitleLbl(btn: bookMarkBtn, text: "حفظ", fontSize: 13)
        customBtn.shadowBtn(btn: bookMarkBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: acceptRequestBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: volunteeringBtn, colorShadow: UIColor.gray.cgColor)
    }
    private func setUpSheetPresentation(){
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    private func setUpData(){
        patientDetailLbl.text = "\(arrOfQuickRequestDetail.first_name) \(arrOfQuickRequestDetail.last_name)"
        bloodTypeDetailLbl.text = arrOfQuickRequestDetail.blood_type
        addressDetailLbl.text = "(\(arrOfQuickRequestDetail.hospital_name))- \(arrOfQuickRequestDetail.city_of_hospital)- \(arrOfQuickRequestDetail.governorate_name)"
        let time = arrOfQuickRequestDetail.time
        let subTime = time.prefix(15)
        timeDetailLbl.text = String(subTime)
        descriptionDetailLbl.text = arrOfQuickRequestDetail.message
        donorImageDetail.load(urlString: arrOfQuickRequestDetail.patient_image)
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
    private func setBookMark(){
        if let isRequestSaved = def.object(forKey: "isRequestSaved")as? Bool{
            if isRequestSaved == true{
                self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
                def.set(true, forKey: "isRequestSaved")
                print(isRequestSaved)
            }else{
                self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark")
                def.set(false, forKey: "isRequestSaved")
                print(isRequestSaved)
            }
        }
    }
    private func bookMarkTapped(){
            if let requestValue = self.def.value(forKey: "isRequestSaved")as? Bool{
                print(requestValue)
                if requestValue == false{
                    self.SuccessAlert(title: "", message: "تم حفظ الطلب في المفضلات❤️", style: .default) { _ in
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
                        self.def.set(true, forKey: "isRequestSaved")
                        print(requestValue)
                    }
                }else{
                    self.SuccessAlert(title: "", message: "تم ازاله الطلب من المفضلات❤️‍🩹", style: .default) { _ in
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark")
                        self.def.set(false, forKey: "isRequestSaved")
                        print(requestValue)
                    }
                }
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
            customBtn.toggleBtnByForground(Btn: insideBookMarkBtn)
            shareContent()
        }
    }
    @IBAction func bookMarkBtnTapped(_ sender: UIButton) {
        
        self.bookMarkTapped()
    }
    @IBAction func volunteeringBtnTapped(_ sender: UIButton) {
        print("volunteering")
        self.animateIn(desireView: blurView)
        self.animateIn(desireView: addCommentView)
    }
    @IBAction func acceptRequestBtnTapped(_ sender: UIButton) {
        print("AcceptReques")
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
