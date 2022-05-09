//
//  DetailsCellViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/03/2022.
//

import UIKit

struct Volunteer {
    let title: String
    let subTitle: String?
}

class DetailsCellViewController: UIViewController, UISheetPresentationControllerDelegate  {
    //MARK: - variabels
    
    @IBOutlet weak var volunteersNumLbl: UILabel!
    @IBOutlet weak var bloodBagNumLbl: UILabel!
    @IBOutlet weak var volunteersTableView: UITableView!
    
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
    var p_ssn = ""
    var requestId = ""
    var arrOfQuickRequestDetail: QuickRequestData!
    var arrOfSavedRequests : [SavedBloodRequestData] = [SavedBloodRequestData]()
    
    let volunteer = [Volunteer(title: "عمرو", subTitle: "12222111"),Volunteer(title: "خالد", subTitle: "1039484848"),Volunteer(title: "Amr", subTitle: "02920920933"),Volunteer(title: "khaled", subTitle: "1221781723"),Volunteer(title: "Amr", subTitle: "12093094090")]
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
        //        def.set(false, forKey: "isRequestSaved")
        //        setBookMark()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSheetPresentation()
        setUpData()
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
        }
        print(self.p_ssn)
        print(self.requestId)
        self.checkRequestIsInfavoriteForDidLoad()
        
    }
    
    //MARK: - Private func
   
    private func setUpDesign(){
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
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
    // data
    private func setUpData(){
        patientDetailLbl.text = "\(arrOfQuickRequestDetail.first_name) \(arrOfQuickRequestDetail.last_name)"
        bloodTypeDetailLbl.text = arrOfQuickRequestDetail.blood_type
        addressDetailLbl.text = "(\(arrOfQuickRequestDetail.hospital_name))- \(arrOfQuickRequestDetail.city_of_hospital)- \(arrOfQuickRequestDetail.governorate_name)"
        let time = arrOfQuickRequestDetail.time
        let subTime = time.prefix(15)
        timeDetailLbl.text = String(subTime)
        descriptionDetailLbl.text = arrOfQuickRequestDetail.message
        volunteersNumLbl.text = arrOfQuickRequestDetail.blood_bags_number
        bloodBagNumLbl.text = arrOfQuickRequestDetail.blood_bags_number
        donorImageDetail.load(urlString: arrOfQuickRequestDetail.patient_image)
    }
    //designs
    private func shareContent(){
        let activityController: UIActivityViewController
        let defaultText = "Hello \(patientDetailLbl.text!),I see you need a \(bloodTypeDetailLbl.text!) group, i Can help you Call me."
        let image = UIImage(named: "blood-donation")
        activityController = UIActivityViewController(activityItems: [defaultText , image!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
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
    private func checkRequestIsInfavoriteForDidLoad(){
        ApiService.sharedService.allSavedBloodRequests { error, savedRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let savedRequest = savedRequest {
                self.arrOfSavedRequests = savedRequest
                for mySavedReq in self.arrOfSavedRequests {
                    if self.requestId == mySavedReq.request_id{
                        print("already exist")
                        self.bookMarkBtn.isEnabled = false
                        self.bookMarkBtn.titleLabel?.text = "تم"
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
                        break
                    }else{
                        self.bookMarkBtn.isEnabled = true
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark")
                    }
                }
            }
        }
    }
    private func checkRequestId(){
        ApiService.sharedService.allSavedBloodRequests { error, savedRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let savedRequest = savedRequest {
                self.arrOfSavedRequests = savedRequest
                if self.arrOfSavedRequests.count == 0{
                    self.addRequestToFavorite()
                }
                for mySavedReq in self.arrOfSavedRequests {
                    if self.requestId == mySavedReq.request_id && self.p_ssn == mySavedReq.p_ssn{
                        print("already exist")
                        break
                    }
                    if self.requestId != mySavedReq.request_id{
                        print(self.requestId)
                        self.addRequestToFavorite()
                        break
                    }
                }
            }
        }
    }
    private func addRequestToFavorite(){
        print(self.requestId)
        ApiService.sharedService.savedBloodRequest(p_ssn: self.p_ssn, request_id: self.requestId)
        self.bookMarkBtn.titleLabel?.text = "تم الحفظ"
        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
    }
    private func bookMarkTapped(){
        self.checkRequestId()
    }
   
    //MARK: - Actions
   
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
       
    }
    @IBAction func acceptRequestBtnTapped(_ sender: UIButton) {
        print("AcceptReques")
    }
   
}
//MARK: - Extension UITableViewDelegate,UITableViewDataSource
extension DetailsCellViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = volunteersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = volunteer[indexPath.row].title
        cell.detailTextLabel?.text = volunteer[indexPath.row].subTitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
