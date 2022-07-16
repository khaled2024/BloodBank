//
//  AppBloodRequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 01/04/2022.
//

import UIKit
import BLTNBoard

class AppBloodRequestViewController: UIViewController{
    // text fields
    @IBOutlet weak var donateReasonTextField: UITextField!
    @IBOutlet weak var requestTypeTextField: UITextField!
    @IBOutlet weak var hospitalTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var governrateTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    
    
    @IBOutlet weak var bloodRequestLbl: UILabel!
    @IBOutlet weak var secondTitleLbl: UILabel!
    //request
    @IBOutlet weak var requestTypeLbl: UILabel!
    @IBOutlet weak var requestNext: UIButton!
    //blood type
    @IBOutlet weak var bloodTitleLbl: UILabel!
    @IBOutlet weak var bloodNextBtn: UIButton!
    @IBOutlet weak var bloodBackBtn: UIButton!
    //number of bags
    @IBOutlet weak var numberOfBagsLbl: UILabel!
    
    @IBOutlet weak var bagsBackBtn: UIButton!
    @IBOutlet weak var bagsNextBtn: UIButton!
    //reason
    @IBOutlet weak var reasonTitleLbl: UILabel!
    @IBOutlet weak var reasonNextBtn: UIButton!
    @IBOutlet weak var reasonBackBtn: UIButton!
    // city
    @IBOutlet weak var cityTitleLbl: UILabel!
    @IBOutlet weak var cityNextBtn: UIButton!
    @IBOutlet weak var cityBackBtn: UIButton!
    //town
    @IBOutlet weak var townTitleLbl: UILabel!
    @IBOutlet weak var townNextBtn: UIButton!
    @IBOutlet weak var townBackBtn: UIButton!
    //hospital
    @IBOutlet weak var hospitalTitleLbl: UILabel!
    @IBOutlet weak var hospitalNextBtn: UIButton!
    @IBOutlet weak var hospitalBackBtn: UIButton!
    //notes
    @IBOutlet weak var notesTitleLbl: UILabel!
    @IBOutlet weak var notesFinishBtn: UIButton!
    
    // views& pickerViews
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var requestTypeView: UIView!
    @IBOutlet weak var bloodTypeView: UIView!
    @IBOutlet weak var numOfBagsView: UIView!
    @IBOutlet weak var reasonRequestView: UIView!
    @IBOutlet weak var hospitalRequestView: UIView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var townView: UIView!
    @IBOutlet weak var numOfBagsPickerView: UIPickerView!
    
    @IBOutlet weak var reguestPageControll: UIPageControl!
    //arrays of data
    var rowOfCity: String = ""
    var rowofGov: String = ""
    var rowOfHospital: String = ""
    var rowofBlood: String = ""
    var rowofRequestType: String = ""
    var rowOfDonateReason: String = ""
    
    var arrOfBlood: [BloodData] = [BloodData]()
    var dicOfBloodType: [String:String] = [:]
    var arrOfRequestType: [RequestBloodTypeData] = [RequestBloodTypeData]()
    var dicOfRequestType: [String:String] = [:]
    var arrOfDonateReason: [DonateReasonData] = [DonateReasonData]()
    var dicOfDonateReason: [String:String] = [:]
    var dicOfGov :[String:String] = [:]
    var finalCities: [String] = []
    var CitiesArr: [DataCities] = [DataCities]()
    var arrOfGov: [GovData] = [GovData]()
    var arrOfCity: [CityData] = [CityData]()
    var dicOfCity :[String:String] = [:]
    var myDicOfCity :[String:String] = [:]
    var finalHospital: [String] = []
    var arrofHospitals:[placesData] = [placesData]()
    var dicOfHospitals :[String:String] = [:]
    //picker views
    let bloodTypePicker = UIPickerView()
    let governratePicker = UIPickerView()
    let cityPicker = UIPickerView()
    let hospitalPicker = UIPickerView()
    let requestTypePicker = UIPickerView()
    let donateReasonPicker = UIPickerView()
    var p_ssn: String!
    //MARK: - vars
    var myCurrentPage = 0
    var numOfBagsResult: String!
    let arrOfBags = Arrays.arrOfBags
    
    let navBar = NavigationBar()
    let customView = CustomView()
    private lazy var fitBoardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Ok".Localized())
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "Ok".Localized()
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"titleRequest".Localized() , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true) {
                //self.navigationController?.popToRootViewController(animated: true)
                let requestsVC = RequestViewController.instantiate()
                self.navigationController?.pushViewController(requestsVC, animated: true)
                self.modalTransitionStyle = .coverVertical
                self.modalPresentationStyle = .fullScreen
            }
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataOfUser()
        setUpData()
        getBlood()
        setGovData()
        setCityData()
        getRequestBloodType()
        getDonateReason()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
        self.localizedItems()
        self.reguestPageControll.numberOfPages = 8
    }
    //MARK: - private functions
    private func setUpData(){
        bloodTypePicker.delegate = self
        bloodTypePicker.dataSource = self
        bloodTypeTextField.inputView = bloodTypePicker
        
        numOfBagsPickerView.delegate = self
        numOfBagsPickerView.dataSource = self
        
        donateReasonPicker.delegate = self
        donateReasonPicker.dataSource = self
        donateReasonTextField.inputView = donateReasonPicker
        
        hospitalPicker.delegate = self
        hospitalPicker.dataSource = self
        hospitalTextField.inputView = hospitalPicker
        
        cityPicker.dataSource = self
        cityPicker.delegate = self
        cityTextField.inputView = cityPicker
        
        governratePicker.dataSource = self
        governratePicker.delegate = self
        governrateTextField.inputView = governratePicker
        
        requestTypePicker.dataSource = self
        requestTypePicker.delegate = self
        requestTypeTextField.inputView = requestTypePicker
        // views display
        requestTypeView.isHidden = false
        bloodTypeView.isHidden = true
        numOfBagsView.isHidden = true
        reasonRequestView.isHidden = true
        cityView.isHidden = true
        townView.isHidden = true
        hospitalRequestView.isHidden = true
        notesView.isHidden = true
        // tags
        requestTypePicker.tag = 0
        bloodTypePicker.tag = 1
        numOfBagsPickerView.tag = 2
        donateReasonPicker.tag = 3
        governratePicker.tag = 4
        cityPicker.tag = 5
        hospitalPicker.tag = 6
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Create Blood Order".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        self.navigationController?.navigationBar.isHidden = false
        // This will show in the next view controller being pushed
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
    
    private func localizedItems(){
        bloodRequestLbl.customLblFont(lbl: bloodRequestLbl, fontSize: 25, text: "First Title")
        secondTitleLbl.customLblFont(lbl: secondTitleLbl, fontSize: 19, text: "Second Title")
        requestTypeLbl.customLblFont(lbl: requestTypeLbl, fontSize: 19, text: "Request Type")
        numberOfBagsLbl.customLblFont(lbl: numberOfBagsLbl, fontSize: 19, text: "Number Of Bags")
        bloodTitleLbl.customLblFont(lbl: bloodTitleLbl, fontSize: 19, text: "Blood Type")
        reasonTitleLbl.customLblFont(lbl: reasonTitleLbl, fontSize: 19, text: "Reason of the Request")
        cityTitleLbl.customLblFont(lbl: cityTitleLbl, fontSize: 19, text: "City Title")
        townTitleLbl.customLblFont(lbl: townTitleLbl, fontSize: 19, text: "Town Title")
        hospitalTitleLbl.customLblFont(lbl: hospitalTitleLbl, fontSize: 19, text: "Hospital Title")
        notesTitleLbl.customLblFont(lbl: notesTitleLbl, fontSize: 19, text: "Notes Title")
        
        requestNext.customTitleLbl(btn: requestNext, text: "Next", fontSize: 18)
        bloodNextBtn.customTitleLbl(btn: bloodNextBtn, text: "Next", fontSize: 18)
        bloodBackBtn.customTitleLbl(btn: bloodBackBtn, text: "Back", fontSize: 18)
        bagsNextBtn.customTitleLbl(btn: bagsNextBtn, text: "Next", fontSize: 18)
        bagsBackBtn.customTitleLbl(btn: bagsBackBtn, text: "Back", fontSize: 18)
        reasonNextBtn.customTitleLbl(btn: reasonNextBtn, text: "Next", fontSize: 18)
        reasonBackBtn.customTitleLbl(btn: reasonBackBtn, text: "Back", fontSize: 18)
        hospitalNextBtn.customTitleLbl(btn: hospitalNextBtn, text: "Next", fontSize: 18)
        hospitalBackBtn.customTitleLbl(btn: hospitalBackBtn, text: "Back", fontSize: 18)
        cityNextBtn.customTitleLbl(btn: cityNextBtn, text: "Next", fontSize: 18)
        cityBackBtn.customTitleLbl(btn: cityBackBtn, text: "Back", fontSize: 18)
        townNextBtn.customTitleLbl(btn: townNextBtn, text: "Next", fontSize: 18)
        townBackBtn.customTitleLbl(btn: townBackBtn, text: "Back", fontSize: 18)
        notesFinishBtn.customTitleLbl(btn: notesFinishBtn, text: "Finish", fontSize: 18)
        customView.requestView(theView: requestTypeView)
        customView.requestView(theView: bloodTypeView)
        customView.requestView(theView: numOfBagsView)
        customView.requestView(theView: reasonRequestView)
        customView.requestView(theView: cityView)
        customView.requestView(theView: townView)
        customView.requestView(theView: hospitalRequestView)
        customView.requestView(theView: notesView)
    }
    func animate(theview: UIView){
        UIView.transition(with: theview, duration: 1, options: [.transitionCurlUp], animations: {
            theview.alpha = 0.0
        }, completion: {_ in
            theview.isHidden = true
        })
    }
    // get data (gov,city,hospital,bloodType,Donate Reason,type of Request)
    private func getBlood(){
        ApiService.sharedService.getBloodType { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                self.arrOfBlood = blood
                for blood in self.arrOfBlood {
                    self.dicOfBloodType[blood.name] = blood.id
                }
                print(self.arrOfBlood)
            }
        }
    }
    private func setGovData(){
        ApiService.sharedService.getGovData { error, gov in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                } else if let gov = gov {
                    self.arrOfGov = gov
                    for gov in self.arrOfGov {
                        self.dicOfGov[gov.id] = gov.name
                    }
                }
            }
        }
    }
    private func getCitiesWithId(id: String){
        ApiService.sharedService.getCitiesById(id: rowofGov) { error, city in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                }else if let city = city {
                    print(city)
                    self.CitiesArr = city
                    self.finalCities = []
                    for cities in self.CitiesArr {
                        print(cities.name)
                        self.finalCities.append(cities.name)
                    }
                    print(self.finalCities)
                }
            }
        }
    }
    private func setCityData(){
        ApiService.sharedService.getCityData { error, city in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                } else if let city = city {
                    self.arrOfCity = city
                    for city in self.arrOfCity {
                        self.dicOfCity[city.gov_id] = city.name
                        self.myDicOfCity[city.name] = city.id
                    }
                    print(self.arrOfCity)
                    
                }
                print("\(self.rowOfCity)")
            }
        }
    }
    private func getRequestBloodType(){
        ApiService.sharedService.getRequestBloodType { error, requestType in
            if let error = error {
                print(error.localizedDescription)
            }else if let requestType = requestType {
                self.arrOfRequestType = requestType
                for requestType in self.arrOfRequestType {
                    self.dicOfRequestType[requestType.type] = requestType.id
                }
                print(self.arrOfRequestType)
            }
        }
    }
    private func getDonateReason(){
        ApiService.sharedService.getDonateReason { error, donateReason in
            if let error = error {
                print(error.localizedDescription)
            }else if let donateReason = donateReason {
                self.arrOfDonateReason = donateReason
                for donateReason in self.arrOfDonateReason {
                    self.dicOfDonateReason[donateReason.reason] = donateReason.id
                }
                print(self.arrOfDonateReason)
            }
        }
    }
    private func setHospitalDatawithId(id: String){
        ApiService.sharedService.getHospitalsById(id: self.rowOfCity) { error, places in
            if let error = error {
                print(error.localizedDescription)
            }else if let places = places {
                self.arrofHospitals = places
                for hospital in self.arrofHospitals {
                    if self.rowOfCity == hospital.city_id{
                        self.finalHospital.append(hospital.place_name)
                        self.dicOfHospitals[hospital.place_name] = hospital.id
                    }else{
                        print("error")
                    }
                }
                print(" dic of hospitals :\(self.dicOfHospitals)")
                print(self.finalHospital)
            }
            if self.finalHospital.count == 0{
                self.showNormalAlert(title: "Sorry", message: "There are no hospitals that you can order Blood in this city.")
                self.hospitalTextField.isEnabled = false
                self.cityTextField.text = ""
            }else{
                self.hospitalTextField.isEnabled = true
            }
        }
    }
    private func sendQuickRequest(){
        ApiService.sharedService.sendQuickBloodRequest(p_ssn: self.p_ssn, message: self.notesTextView.text, donateReason: self.rowOfDonateReason, bloodType: self.rowofBlood, requestType: self.rowofRequestType, bloodBagNum: numOfBagsResult, placeId: self.rowOfHospital)
    }
    private func setDataOfUser(){
        let def = UserDefaults.standard
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
            print(self.p_ssn!)
            print("city id : \(userInfo[12])")
        }
    }
    //MARK: - Actions
    @IBAction func requestTypenextBtn(_ sender: UIButton) {
        animate(theview: requestTypeView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.bloodTypeView.isHidden = false
            self.bloodTypeView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    //blood type
    @IBAction func nextbloodTypeBtnTapped(_ sender: UIButton) {
        animate(theview: bloodTypeView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.numOfBagsView.isHidden = false
            self.numOfBagsView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    @IBAction func backBloodType(_ sender: UIButton) {
        self.animate(theview: self.bloodTypeView)
        self.requestTypeView.isHidden = false
        requestTypeView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    // Num of bags
    @IBAction func bagsNextBtnTapped(_ sender: UIButton) {
        animate(theview: numOfBagsView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.reasonRequestView.isHidden = false
            self.reasonRequestView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    @IBAction func bagsBackBtnTapped(_ sender: UIButton) {
        self.animate(theview: self.numOfBagsView)
        self.bloodTypeView.isHidden = false
        self.requestTypeView.isHidden = true
        bloodTypeView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    //reason
    @IBAction func reasonNextTapped(_ sender: UIButton) {
        animate(theview: reasonRequestView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.cityView.isHidden = false
            self.cityView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    @IBAction func reasonBackTapped(_ sender: UIButton) {
        animate(theview: reasonRequestView)
        numOfBagsView.isHidden = false
        requestTypeView.isHidden = true
        bloodTypeView.isHidden = true
        self.numOfBagsView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    // city
    @IBAction func cityNextBtnTapped(_ sender: UIButton) {
        animate(theview: cityView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.townView.isHidden = false
            self.townView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    @IBAction func cityBackBtnTapped(_ sender: UIButton) {
        animate(theview: cityView)
        reasonRequestView.isHidden = false
        bloodTypeView.isHidden = true
        numOfBagsView.isHidden = true
        requestTypeView.isHidden = true
        self.reasonRequestView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    //town
    @IBAction func townNextBtnTapped(_ sender: UIButton) {
        animate(theview: townView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.hospitalRequestView.isHidden = false
            self.hospitalRequestView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
        setHospitalDatawithId(id: self.rowOfCity)
    }
    @IBAction func townBackBtnTapped(_ sender: UIButton) {
        animate(theview: townView)
        cityView.isHidden = false
        requestTypeView.isHidden = true
        bloodTypeView.isHidden = true
        numOfBagsView.isHidden = true
        requestTypeView.isHidden = true
        self.cityView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    // hospital
    @IBAction func hospitalNext(_ sender: UIButton) {
        animate(theview: hospitalRequestView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.notesView.isHidden = false
            self.notesView.alpha = 1
            self.myCurrentPage += 1
            self.reguestPageControll.currentPage = self.myCurrentPage
        }
    }
    @IBAction func hospitalBackTapped(_ sender: UIButton) {
        animate(theview: hospitalRequestView)
        townView.isHidden = false
        reasonRequestView.isHidden = true
        cityView.isHidden = true
        numOfBagsView.isHidden = true
        bloodTypeView.isHidden = true
        requestTypeView.isHidden = true
        self.townView.alpha = 1
        self.myCurrentPage -= 1
        self.reguestPageControll.currentPage = self.myCurrentPage
    }
    //notes
    @IBAction func finishNotesTapped(_ sender: UIButton) {
        if let noteResult = notesTextView.text , !noteResult.isEmpty,let requestType = requestTypeTextField.text , !requestType.isEmpty , let donateReason = self.donateReasonTextField.text , !donateReason.isEmpty, let bloodType = self.bloodTypeTextField.text , !bloodType.isEmpty , let numOfBags = self.numOfBagsResult , !numOfBags.isEmpty, let gov = self.governrateTextField.text , !gov.isEmpty , let city = self.cityTextField.text , !city.isEmpty , let hospital = self.hospitalTextField.text , !hospital.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.sendQuickRequest()
                print("\(self.rowofBlood) - \(self.rowOfHospital) - \(self.rowofRequestType) - \(self.rowOfDonateReason) - \(noteResult)")
            }
            self.fitBoardManager.showBulletin(above: self)
        }else{
            showNormalAlert(title: "Sorry", message: "Please write a message for Donors.")
        }
    }
}
//MARK: - UIPickerViewDelegate
extension AppBloodRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 0:
            return dicOfRequestType.count
        case 1:
            return dicOfBloodType.count
        case 2:
            return arrOfBags.count
        case 3:
            return dicOfDonateReason.count
        case 4:
            return dicOfGov.count
        case 5:
            return finalCities.count
        case 6:
            return dicOfHospitals.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 0:
            return arrOfRequestType[row].type
        case 1:
            return self.arrOfBlood[row].name
        case 2:
            self.numOfBagsResult = arrOfBags[row]
            return arrOfBags[row]
        case 3:
            return arrOfDonateReason[row].reason
        case 4:
            return self.arrOfGov[row].name
        case 5:
            return self.finalCities[row]
        case 6:
            
            return finalHospital[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 0:
            self.rowofRequestType = arrOfRequestType[row].id
            self.requestTypeTextField.text = arrOfRequestType[row].type
            print(self.rowofRequestType)
        case 1:
            self.rowofBlood = arrOfBlood[row].id
            self.bloodTypeTextField.text = arrOfBlood[row].name
            print(self.rowofBlood)
        case 2:
            self.numOfBagsResult = arrOfBags[row]
        case 3:
            self.rowOfDonateReason = arrOfDonateReason[row].id
            self.donateReasonTextField.text = arrOfDonateReason[row].reason
            print(self.rowOfDonateReason)
        case 4:
            self.rowofGov = arrOfGov[row].id
            self.governrateTextField.text = arrOfGov[row].name
            print(self.rowofGov)
            self.getCitiesWithId(id: rowofGov)
        case 5:
            cityTextField.text = self.finalCities[row]
            self.rowOfCity = myDicOfCity[self.cityTextField.text!]!
            print("city id in picker view : \(self.rowOfCity)")
        case 6:
            self.hospitalTextField.text = finalHospital[row]
            self.rowOfHospital = dicOfHospitals[hospitalTextField.text!]!
            print(self.rowOfHospital)
            print("final hospitals : \(finalHospital)")
            
        default:
            return
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}



