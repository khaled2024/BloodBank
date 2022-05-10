//
//  HistoryRequestDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 09/05/2022.
//

import UIKit
class HistoryRequestDetailsViewController: UIViewController, UISheetPresentationControllerDelegate  {
    //MARK: - variabels
    @IBOutlet weak var noVolunteerLbl: UILabel!
    @IBOutlet weak var noVolunteersData: UIImageView!
    @IBOutlet weak var bloddBagsNumLbl: UILabel!
    @IBOutlet weak var volunteersNumLbl: UILabel!
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
    @IBOutlet weak var acceptRequestBtn: UIButton!
    @IBOutlet weak var insideacceptRequestBtn: UIButton!
    
    let customBtn = UserCustomBtn()
    @IBOutlet weak var sharingBtn: UIButton!
    var myPatient: Patient!
    let customView = CustomView()
    let def = UserDefaults.standard
    var p_ssn = ""
    var requestId = ""
    var arrOfPrivateHistoryRequestDetail: QuickRequestData!
    var arrOfSavedRequests : [SavedBloodRequestData] = [SavedBloodRequestData]()
    var arrOfDonors: [String] = []
    var volunteersNum = 0
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
                        self.acceptRequestBtn.isEnabled = false
                        self.insideacceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
                        
                    }
                    
                }
                print("volunteer of this request : \(self.volunteersNum)")
            }
        }
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
    private func setUpDesign(){
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
//        self.acceptRequestBtn.customTitleLbl(btn: acceptRequestBtn, text: "تلبيه الطلب", fontSize: 13)
//        self.bookMarkBtn.customTitleLbl(btn: bookMarkBtn, text: "حفظ", fontSize: 13)
        customBtn.shadowBtn(btn: bookMarkBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: acceptRequestBtn, colorShadow: UIColor.gray.cgColor)
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
        patientDetailLbl.text = "\(arrOfPrivateHistoryRequestDetail.first_name) \(arrOfPrivateHistoryRequestDetail.last_name)"
        bloodTypeDetailLbl.text = arrOfPrivateHistoryRequestDetail.blood_type
        addressDetailLbl.text = "(\(arrOfPrivateHistoryRequestDetail.hospital_name))- \(arrOfPrivateHistoryRequestDetail.city_of_hospital)- \(arrOfPrivateHistoryRequestDetail.governorate_name)"
        let time = arrOfPrivateHistoryRequestDetail.time
        let subTime = time.prefix(15)
        timeDetailLbl.text = String(subTime)
        descriptionDetailLbl.text = arrOfPrivateHistoryRequestDetail.message
        bloddBagsNumLbl.text = arrOfPrivateHistoryRequestDetail.blood_bags_number
        volunteersNumLbl.text = String(self.volunteersNum)
        donorImageDetail.load(urlString: arrOfPrivateHistoryRequestDetail.patient_image)
    }
    
    
    //designs
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
  
    private func checkRequestIsInfavoriteForDidLoad(){
        ApiService.sharedService.allSavedBloodRequests { error, savedRequest in
            if let error = error {
                print(error.localizedDescription)
            }else if let savedRequest = savedRequest {
                self.arrOfSavedRequests = savedRequest
                for mySavedReq in self.arrOfSavedRequests {
                    if self.requestId == mySavedReq.request_id && self.p_ssn == mySavedReq.p_ssn{
                        print("already exist")
                        self.bookMarkBtn.isEnabled = false
                        self.bookMarkBtn.setTitle("تم الحفظ", for: .normal  )
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
    }
    private func bookMarkTapped(){
        
    }
    private func acceptRequest(){
        if self.volunteersNum >= 8{
            self.showNormalAlert(title: "للاسف", message: "تم اكتمال عدد المتطوعين لهذا الطلب :)")
            self.acceptRequestBtn.isEnabled = false
            self.insideacceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
        }else{
            print(self.requestId)
            print(self.p_ssn)
            ApiService.sharedService.acceptRequest(request_id: self.requestId, donner_id: self.p_ssn)
            self.showNormalAlert(title: "احسنت", message: "لقد تم التطوع للمساعده في هذا الطلب :)")
        }
        
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
        self.checkRequestId()
    }
    
    @IBAction func acceptRequestBtnTapped(_ sender: UIButton) {
        print("accept request")
        acceptRequest()
    }
    
}
//MARK: - Extension UITableViewDelegate,UITableViewDataSource
extension HistoryRequestDetailsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
}

