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
    
    let comment = [Comment(title: "Amr", subTitle: "i can help you in this blood request send me all details i can help you in this blood request send me all details i can help you in this blood request send me all details"),Comment(title: "khaled", subTitle: "i can help you in this blood request send me all details"),Comment(title: "Amr", subTitle: "i can help you in this blood request send me all details i can help you in this blood request send me all details"),Comment(title: "khaled", subTitle: "i can help you in this blood request send me all details"),Comment(title: "Amr", subTitle: "i can help you in this blood request send me all details")]
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
    }
    
    //MARK: - Private func
    private func setUpDesign(){
        self.likeBtn.customTitleLbl(btn: likeBtn, text: "Like", fontSize: 20)
        self.commentBtn.customTitleLbl(btn: commentBtn, text: "Comment", fontSize: 20)
        self.shareBtn.customTitleLbl(btn: shareBtn, text: "Share", fontSize: 20)
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
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
    
    //MARK: - Actions
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
    }
    @IBAction func likeBtnTapped(_ sender: UIButton) {
        print("liked")
        customBtn.toggleBtnByForground(Btn: insidelikedBtn)
    }
    @IBAction func phoneBtnTapped(_ sender: UIButton) {
        
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
