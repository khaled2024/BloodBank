//
//  FavoriteDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 09/05/2022.
//

import UIKit

class FavoriteDetailsViewController: UIViewController, UISheetPresentationControllerDelegate  {
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
    @IBOutlet weak var insideAcceptRequestBtn: UIButton!
    @IBOutlet weak var acceptRequestBtn: UIButton!
    let customBtn = UserCustomBtn()
    @IBOutlet weak var sharingBtn: UIButton!
    var myPatient: Patient!
    let customView = CustomView()
    let def = UserDefaults.standard
    var p_ssn = ""
    var requestId = ""
    var requestIdOfFaorite = ""
    var arrOfFavoriteRequestDetail: QuickRequestData!
    var arrOfSavedRequests : [SavedBloodRequestData] = [SavedBloodRequestData]()
    var tableView = UITableView()
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
        checkVolunteerMaximum()
        self.allGoingDonor(idOfRequest: self.requestId)
        print(self.p_ssn)
        print(self.requestId)
        print(self.requestIdOfFaorite)
        
//        self.checkRequestIsInfavoriteForDidLoad()
        self.getVolunteerData()
        self.getDonorsDetails()
        setUpSheetPresentation()
    }
    //MARK: - Private func
    
    private func setUpDesign(){
        self.donorImageDetail.layer.cornerRadius = self.donorImageDetail.frame.size.width / 2
//        self.acceptRequestBtn.customTitleLbl(btn: acceptRequestBtn, text: "تلبيه الطلب", fontSize: 13)
//
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
        patientDetailLbl.text = "\(arrOfFavoriteRequestDetail.first_name) \(arrOfFavoriteRequestDetail.last_name)"
        bloodTypeDetailLbl.text = arrOfFavoriteRequestDetail.blood_type
        addressDetailLbl.text = "(\(arrOfFavoriteRequestDetail.hospital_name))- \(arrOfFavoriteRequestDetail.city_of_hospital)- \(arrOfFavoriteRequestDetail.governorate_name)"
        let time = arrOfFavoriteRequestDetail.time
        let subTime = time.prefix(15)
        timeDetailLbl.text = String(subTime)
        descriptionDetailLbl.text = arrOfFavoriteRequestDetail.message
        bloddBagsNumLbl.text = arrOfFavoriteRequestDetail.blood_bags_number
        volunteersNumLbl.text = String(self.volunteersNum)
        donorImageDetail.load(urlString: arrOfFavoriteRequestDetail.patient_image)
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
    private func setBookMark(){
        if let isRequestSaved = def.object(forKey: "isRequestSaved")as? Bool{
            if isRequestSaved == true{
                def.set(true, forKey: "isRequestSaved")
                print(isRequestSaved)
            }else{
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
                        print("saved")
                        
                        break
                    }
                }
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
                    if self.arrOfDonors.count == 8{
                        self.showNormalAlert(title: "للاسف", message: "تم اكتمال عدد المتطوعين لهذا الطلب :)")
                        print("تم اكتمال عدد المتطوعين لهذا الطلب :)")
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
                        self.insideAcceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
                    }
                }
                print("volunteer of this request : \(self.volunteersNum)")
            }
        }
    }
    private func checkVolunteerMaximum(){
        if self.volunteersNum >= 8{
            showNormalAlert(title: "للاسف", message: "تم اكتمال عدد المتطوعين لهذا الطلب :)")
        }
    }
    private func acceptRequest(){
        if self.volunteersNum >= 8{
            self.showNormalAlert(title: "للاسف", message: "تم اكتمال عدد المتطوعين لهذا الطلب :)")
            self.acceptRequestBtn.isEnabled = false
            self.acceptRequestBtn.isEnabled = false
            self.insideAcceptRequestBtn.imageView?.image = UIImage(systemName: "hand.thumbsup.fill")
            
        }else{
            print(self.requestId)
            print(self.p_ssn)
            ApiService.sharedService.acceptRequest(request_id: self.requestId, donner_id: self.p_ssn)
            self.acceptRequestBtn.setTitle("تم التطوع", for: .normal)
            self.acceptRequestBtn.isEnabled = false
            
            self.showNormalAlert(title: "احسنت", message: "لقد تم التطوع للمساعده في هذا الطلب :)")
        }
        
    }
    private func nonBookMarkTapped(){
        print(self.requestIdOfFaorite)
        tableView.beginUpdates()
        ApiService.sharedService.deleteFavoriteRequest(id: requestIdOfFaorite)
        //        self.arrOfSavedRequests.remove(at: indexPath.row)
        //        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    //MARK: - Actions
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        if sender == sharingBtn{
            shareContent()
        }else{
            print("shared")
            shareContent()
        }
    }
    @IBAction func bookMarkBtnTapped(_ sender: UIButton) {
        self.nonBookMarkTapped()
    }
    @IBAction func acceptRequestBtnTapped(_ sender: UIButton) {
        print("Accept request")
        acceptRequest()
    }
}
//MARK: - Extension UITableViewDelegate,UITableViewDataSource
extension FavoriteDetailsViewController: UITableViewDelegate,UITableViewDataSource {
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

