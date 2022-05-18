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
struct myVolunteer {
    let Name: String
    let PhoneNumber: String
}

class DetailsCellViewController: UIViewController, UISheetPresentationControllerDelegate  {
    //MARK: - variabels
    
    @IBOutlet weak var noVolunteerLbl: UILabel!
    @IBOutlet weak var noVolunteersData: UIImageView!
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
    
    let customBtn = UserCustomBtn()
    @IBOutlet weak var sharingBtn: UIButton!
    var myPatient: Patient!
    let customView = CustomView()
    let def = UserDefaults.standard
    var arrOfDonors: [String] = []
    var p_ssn = ""
    var requestId = ""
    var IdOfRequestForDeletion = "error in request id"
    var volunteersNum = 0
    var arrOfQuickRequestDetail: QuickRequestData!
    var arrOfSavedRequests : [SavedBloodRequestData] = [SavedBloodRequestData]()
    
    var volunt = [myVolunteer]()
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    //MARK: - LifeCycle
    override func viewWillLayoutSubviews() {
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
        }
        setUpData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
        self.getIdOfGoingRequestForDeletion()
        self.insideAcceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allGoingDonor(idOfRequest: self.requestId)
        print(self.p_ssn)
        print(self.requestId)
        self.checkRequestIsInfavoriteForDidLoad()
        self.getVolunteerData()
        self.getDonorsDetails()
        setUpSheetPresentation()
    }
    
    //MARK: - Private func
    private func setUpDesign(){
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
        //        self.acceptRequestBtn.customTitleLbl(btn: acceptRequestBtn, text: "تلبيه الطلب", fontSize: 15)
        //
        //        self.bookMarkBtn.customTitleLbl(btn: bookMarkBtn, text: "حفظ", fontSize: 15)
        customBtn.shadowBtn(btn: bookMarkBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: acceptRequestBtn, colorShadow: UIColor.gray.cgColor)
        
    }
    private func getVolunteerData(){
        ApiService.sharedService.allGoingAccept { error, goingRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let goingRequest = goingRequest {
                for goingRequest in goingRequest{
                    if self.requestId == goingRequest.request_id{
                        self.arrOfDonors.append(goingRequest.donner_id)
                        self.volunteersTableView.isHidden = false
                        self.noVolunteersData.isHidden = true
                        self.noVolunteerLbl.isHidden = true
                    }
                    if self.arrOfDonors.count == 0{
                        self.volunteersTableView.isHidden = true
                        self.noVolunteersData.isHidden = false
                        self.noVolunteerLbl.isHidden = false
                    }
                }
                print("arr of donors\(self.arrOfDonors)")
            }
            self.volunteersTableView.reloadData()
        }
    }
    private func getDonorsDetails(){
        ApiService.sharedService.checkSignIn { error, user in
            if let error = error {
                print(error.localizedDescription)
            }else if let user = user {
                for user in user {
                    for donor in self.arrOfDonors {
                        if user.p_ssn == donor{
                            self.volunt.append(myVolunteer(Name: "\(user.p_first_name) \(user.p_last_name)", PhoneNumber: user.mobile_phone))
                        }
                    }
                    
                }
                print("Volunteers :\(self.volunt)")
            }
            self.volunteersTableView.reloadData()
        }
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
        volunteersNumLbl.text = String(self.volunteersNum)
        print(self.volunteersNumLbl.text!)
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
                    if self.requestId == mySavedReq.request_id && self.p_ssn == mySavedReq.p_ssn{
                        print("already exist")
                        self.bookMarkBtn.setTitle("تم الحفظ", for: .normal)
                        self.bookMarkBtn.isEnabled = false
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
                        break
                    }else{
                        self.bookMarkBtn.isEnabled = true
                        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
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
        self.bookMarkBtn.setTitle("تم الحفظ", for: .normal)
        self.bookMarkBtn.isEnabled = false
        self.insideBookMarkBtn.imageView?.image = UIImage(systemName: "bookmark.fill")
        self.showNormalAlert(title: "للاسف ", message: "تمت الاضافه في المفضلات :)")
        
    }
    private func bookMarkTapped(){
        self.checkRequestId()
    }
    func allGoingDonor(idOfRequest: String){
        print(idOfRequest)
        ApiService.sharedService.allGoingAccept { error, goingRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let goingRequest = goingRequest {
                for myGoingRequest in goingRequest{
                    if self.requestId == myGoingRequest.request_id{
                        self.volunteersNum += 1
                    }
                    if self.p_ssn == myGoingRequest.donner_id && idOfRequest == myGoingRequest.request_id{
                        self.showNormalAlert(title: "للاسف ", message: "لقد تطوعت لهذا الطلب من قبل ")
                        self.acceptRequestBtn.setTitle("تم التطوع", for: .normal)
//                        self.acceptRequestBtn.isEnabled = false
                        self.insideAcceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
                        
                    }
                    
                }
                print("volunteer of this request : \(self.volunteersNum)")
            }
        }
    }
    
    private func acceptRequest(){
        if self.volunteersNum >= 8{
            self.showNormalAlert(title: "للاسف", message: "تم اكتمال عدد المتطوعين لهذا الطلب :)")
//            self.acceptRequestBtn.isEnabled = false
            self.insideAcceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
        }else{
            print(self.requestId)
            print(self.p_ssn)
            ApiService.sharedService.acceptRequest(request_id: self.requestId, donner_id: self.p_ssn)
            self.acceptRequestBtn.setTitle("تم التطوع", for: .normal)
//            self.acceptRequestBtn.isEnabled = false
            self.showNormalAlert(title: "احسنت", message: "لقد تم التطوع للمساعده في هذا الطلب :)")
        }
    }
    private func getIdOfGoingRequestForDeletion(){
        ApiService.sharedService.allGoingAccept { error, goingRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let goingRequest = goingRequest {
                for goingRequest in goingRequest {
                    if self.p_ssn == goingRequest.donner_id && self.requestId == goingRequest.request_id{
                        self.IdOfRequestForDeletion = goingRequest.id
                       
                    }
                }
                print(" id of request for deletion : \(self.IdOfRequestForDeletion)")
            }
        }
    }
    private func refuseRequest(){
        ApiService.sharedService.deleteGoingRequest(id: self.IdOfRequestForDeletion)
    }
    //MARK: - Actions
    @IBAction func volunteerBtnTapped(_ sender: UIButton) {
        //        self.getVolunteerData()
        //        self.getDonorsDetails()
        //        self.volunteersTableView.isHidden = false
    }
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        if sender == sharingBtn{
            shareContent()
        }
    }
    @IBAction func bookMarkBtnTapped(_ sender: UIButton) {
        self.bookMarkTapped()
    }
    @IBAction func acceptRequestBtnTapped(_ sender: UIButton) {
        
        if acceptRequestBtn.titleLabel?.text == "تلبيه الطلب"{
            print("AcceptRequests")
            self.acceptRequest()
        }else{
            print("refuseRquest")
            self.refuseRequest()
            self.showNormalAlert(title: "", message: "تم الغاء الطلب بنجاح :(")
            self.acceptRequestBtn.setTitle("تلبيه الطلب", for: .normal)
        }
    }
}
//MARK: - Extension UITableViewDelegate,UITableViewDataSource
extension DetailsCellViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(volunt.count)
        return volunt.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = volunteersTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = volunt[indexPath.row].Name
        cell.detailTextLabel?.text = volunt[indexPath.row].PhoneNumber
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //for animations
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.35) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
