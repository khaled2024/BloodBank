//
//  BuyBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/04/2022.
//

import UIKit
import BLTNBoard

class BuyBloodViewController: UIViewController{
    //MARK: - outles
    @IBOutlet weak var placeChoiseTF: UITextField!
    @IBOutlet weak var orderRequestBtn: UIButton!
    @IBOutlet weak var bloodBagsTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    @IBOutlet weak var findingBloodError: UILabel!
    //MARK: - vars
    let navBar = NavigationBar()
    let def = UserDefaults.standard
    //data
    var p_ssn: String!
    var cityId: String!
    var govId: String!
    var rowofBlood: String = "1"
    var arrOfBlood: [BloodData] = [BloodData]()
    var dicOfBloodType: [String:String] = [:]
    var price: String!
    var amount: String!
    var numOfBags: String = "1"
    var totalPrice: String!
    var idOfHospital: String!
    var arrOfOtherCities: [String] = []
    var finalIdOfHospial: String!
    var arrOfOtherHospitals: [String] = []
    var arrOfNamesOtherHospitals: [String] = []
    var msg: [x]!
    var oneMsg: y!
    var final_place_id: String!
    var arrOfFinalPlaceId: [String] = []
    var HospitalName:String!
    var idOfAvailableBlood: String!
    var arrOfAvailableBloodPlaces: [String] = []
    var arrOfAvailableBloodCitiesIds: [String] = []
    var arrOfAvailableBloodCitiesName: [String] = [""]
    var selectedPlaceId: String!
    
    var placeChoisePickerView = UIPickerView()
    let bloodTypePickerView = UIPickerView()
    let bloodBagsPickerView = UIPickerView()
    
    private lazy var canBuyBlood: BLTNItemManager = {
        let item = BLTNPageItem(title: "Congratulation")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"تم تقديم طلبك بنجاح" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true)
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    private lazy var cantBuyBlood: BLTNItemManager = {
        let item = BLTNPageItem(title: "Sorry")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"هذا الدم غير متوافر حاليا و سيتم تقديم طلبك والرد عليك لاحقا" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true)
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.p_ssn = userInfo[0]
            self.cityId = userInfo[12]
            print("my city id: \(self.cityId!))")
        }
        //data
        self.getBlood()
        self.BloodInfo()
        searchInOtherCities()
        //        searchInOtherGov()
        //        self.orderRequest(id: "1")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: - private func
    private func setUp(){
      
        bloodBagsTextField.inputView = bloodBagsPickerView
        bloodTypeTextField.inputView = bloodTypePickerView
        placeChoiseTF.inputView = placeChoisePickerView
        
        bloodBagsPickerView.delegate = self
        bloodBagsPickerView.dataSource = self
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        placeChoisePickerView.delegate = self
        placeChoisePickerView.dataSource = self
        bloodTypePickerView.tag = 0
        bloodBagsPickerView.tag = 1
        placeChoisePickerView.tag = 2
    }
    //design
    private func setUpDesign(){
        placeChoiseTF.isHidden = true
        self.findingBloodError.isHidden = true
        navBar.setNavBar(myView: self, title: "Buy Blood".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    //MARK: - getting data
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
    private func BloodInfo(){
        ApiService.sharedService.getAllBloodInfo { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                for blood in blood {
                    if self.rowofBlood == blood.blood_type_id{
                        self.amount = blood.amount
                        print(self.amount!)
                        self.price = blood.price
                        print(self.price!)
                        self.priceTextField.text = "\(self.price!) جنيهاً"
                        self.totalPrice = blood.price
                        self.totalPriceTextField.text = "\(self.totalPrice!) جنيهاً"
                        break
                    }else{
                        print("error of getting blood info :(")
                        self.priceTextField.text = ""
                        self.totalPriceTextField.text = ""
                    }
                    print(self.priceTextField.text!)
                    print(self.totalPriceTextField.text!)
                }
            }
        }
    }
    private func changePriceWithNumOfBags(){
        let Totalprice: Int = (Int(self.numOfBags) ?? 0) * (Int(self.price) ?? 0)
        self.totalPriceTextField.text = String("\(Totalprice) جنيهاً")
    }
    private func getDelivered_place(){
        ApiService.sharedService.getDonatePlace { error, places in
            if let error = error {
                print(error.localizedDescription)
            }else if let places = places {
                    for otherCity in self.arrOfOtherCities {
                        for place in places {
                            if self.cityId == place.city_id{
                                self.idOfHospital = place.id
                                print(self.idOfHospital!)
                            }
                        }
                        self.cityId = otherCity
                    }
                
                print(self.idOfHospital ?? "error in id of hospital")
            }
            self.checkForAvailableBloodInHospital(idOfHospital: self.idOfHospital)
        }
    }
    private func checkForAvailableBloodInHospital(idOfHospital: String){
        ApiService.sharedService.getAllBloodInfo { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                for blood in blood {
                    if idOfHospital == blood.hospital_id && self.rowofBlood == blood.blood_type_id && self.numOfBags < blood.amount{
                        self.finalIdOfHospial = idOfHospital
                        print("my final id of hospital : \(self.finalIdOfHospial!)")
                        self.showNormalAlert(title: "", message: "تم العثور علي فصيله دم من نوع \(self.bloodTypeTextField.text!) في \(blood.hospital_name)")
                        self.findingBloodError.isHidden = false
                        self.findingBloodError.text = "تم العثور علي فصيله دم من نوع \(self.bloodTypeTextField.text!) في \(blood.hospital_name)"
                        self.orderRequestBtn.isEnabled = true
                        self.placeChoiseTF.isHidden = false
                        break
                    }
                    if idOfHospital != blood.hospital_id || self.rowofBlood != blood.blood_type_id || self.numOfBags > blood.amount{
                        self.findingBloodError.isHidden = false
                        self.findingBloodError.text = "لم يتم العثور علي فصيله دم من نوع \(self.bloodTypeTextField.text!) بالقرب منك حدد المكان الذي تريد شراء الدم منه!"
                        self.orderRequestBtn.isEnabled = false
                        self.placeChoiseTF.isHidden = false
                        if self.arrOfAvailableBloodCitiesName.count == 0{
                            self.placeChoiseTF.isEnabled = false
                            self.placeChoiseTF.placeholder = "لم يتوفر مكان حتي الان لشراء الدم"
                        }else{
                            self.placeChoiseTF.isEnabled = true
                            self.orderRequestBtn.isEnabled = false
                            self.placeChoiseTF.placeholder = "حدد المكان الذي تريد شراء الدم منه"
                        }
                    }
                }
                print("final id of hospital : \(self.finalIdOfHospial ?? "")")
            }
        }
    }
    private func searchInOtherCities(){
        ApiService.sharedService.getCityData { error, city in
            if let error = error {
                print(error.localizedDescription)
            }else if let city = city {
                for city in city {
                    if self.cityId == city.id{
                        self.govId = city.gov_id
                    }
                }
                for city in city {
                    if self.govId == city.gov_id{
                        print("other city id:\(city.id)")
                        self.arrOfOtherCities.append(city.id)
                    }else{
                        print("error in other cities id")
                    }
                }
                print("arrOfOtherCities\(self.arrOfOtherCities)")
            }
        }
    }
    private func getIdOfAvailableBlood(){
        print(self.rowofBlood)
        ApiService.sharedService.getAvailableBlood { error, availableblood in
            if let error = error {
                print(error.localizedDescription)
            }else if let availableblood = availableblood {
                for availableblood in availableblood {
                    if self.idOfHospital == availableblood.placeID && self.rowofBlood == availableblood.bloodTypeID{
                        self.idOfAvailableBlood = availableblood.id
                        print("idOfAvailableBlood: \(self.idOfAvailableBlood ?? "nill in idOfAvailableBlood")")
                    }
                }
            }
        }
    }
    private func getAllAvailableBloodPlacesInCountry(){
        self.arrOfAvailableBloodPlaces = []
        ApiService.sharedService.getAvailableBlood { error, availableblood in
            if let error = error {
                print(error.localizedDescription)
            }else if let availableblood = availableblood {
                for data in availableblood {
                    if self.rowofBlood == data.bloodTypeID{
                        self.arrOfAvailableBloodPlaces.append(data.placeID)
                    }
                }
                print(self.arrOfAvailableBloodPlaces)
            }
        }
    }
    private func getCityIdOfAvailableBloodPlace(){
        self.arrOfAvailableBloodCitiesIds = []
        self.arrOfAvailableBloodCitiesName = []
        ApiService.sharedService.getDonatePlace { error, places in
            if let error = error {
                print(error.localizedDescription)
            }else if let places = places {
                for place in places {
                    for data in self.arrOfAvailableBloodPlaces{
                        if data == place.id{
                            print("first place id  \(place.id) - \(place.place_name)")
                            self.arrOfAvailableBloodCitiesIds.append(place.id)
                            self.arrOfAvailableBloodCitiesName.append(place.place_name)
                        }
                    }
                }
                print("arrOfAvailableBloodCitiesIds is = \(self.arrOfAvailableBloodCitiesIds)")
            }
        }
    }
    //    private func searchInOtherGov(){
    //        ApiService.sharedService.getAllBloodInfo { error, blood in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }else if let blood = blood {
    //                for blood in blood {
    //                    if self.rowofBlood == blood.blood_type_id && self.numOfBags <= blood.amount{
    //                        self.arrOfOtherHospitals.append(blood.hospital_id)
    //                        self.arrOfNamesOtherHospitals.append(blood.hospital_name)
    //                    }
    //                }
    //                print(self.arrOfOtherHospitals)
    //                print(self.arrOfNamesOtherHospitals)
    //            }
    //        }
    //    }
    //    private func getMyData(){
    //        ApiService.sharedService.getMsg(p_ssn: self.p_ssn, city_id: self.cityId, blood_id: self.rowofBlood, amount: self.numOfBags) { error, mydata in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }else if let mydata = mydata {
    //                self.msg = mydata
    //                for mydata in mydata {
    //                    print(self.msg!)
    //                    self.arrOfFinalPlaceId.append(mydata.placeID)
    //                }
    //                print(self.arrOfFinalPlaceId )
    //            }
    //        }
    //    }
    //    private func getOnlyData(){
    //        print(self.p_ssn!)
    //        print(self.cityId!)
    //        print(self.rowofBlood)
    //        print(self.numOfBags)
    //        ApiService.sharedService.getOneMsg(p_ssn: self.p_ssn, city_id: self.cityId, blood_id: self.rowofBlood, amount: self.numOfBags) { error, mydata in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }else if let mydata = mydata {
    //                self.oneMsg = mydata
    //                print(self.oneMsg!)
    //                self.final_place_id = self.oneMsg.placeID
    //                if self.final_place_id.isEmpty == false{
    //                    self.findingBloodError.isHidden = false
    //                    self.getPlaceNameWithId()
    ////                    self.orderRequest(id: self.final_place_id)
    //                }
    //            }
    //            print(self.final_place_id ?? "error")
    //        }
    //    }
    //    private func getPlaceNameWithId(){
    //        ApiService.sharedService.getAllBloodInfo { error, blood in
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }else if let blood = blood {
    //                for blood in blood {
    //                    if self.final_place_id == blood.hospital_id{
    //                        self.HospitalName = blood.hospital_name
    //                        self.findingBloodError.text = "تم العثور علي فصيله دم من نوع \(self.bloodTypeTextField.text!) في \(blood.hospital_name)"
    //                        print(self.HospitalName!)
    //                    }
    //                }
    //            }
    //        }
    //    }
    private func orderRequest(){
        print("---------")
        print(self.p_ssn!)
        print(self.rowofBlood)
        print(self.numOfBags)
        
        ApiService.sharedService.orderBlood(p_ssn: self.p_ssn, blood_type: self.rowofBlood, delivered_place: self.finalIdOfHospial, amount: self.numOfBags)
        print("---------")
        let updatedAmount: Int = Int(self.amount)! - Int(self.numOfBags)!
        ApiService.sharedService.updateOrderBlood(idOfAvailableBlood: self.idOfAvailableBlood ,amount: String(updatedAmount))
//        print("available blood is \(self.idOfAvailableBlood!)")
    }
    private func buyBlood(){
        print(self.p_ssn!)
        print(self.cityId!)
        print(self.rowofBlood)
        print(self.numOfBags)
        print("#############")
        //        self.getMyData()
        //        self.getOnlyData()
        //                ApiService.sharedService.buyBlood(p_ssn: self.p_ssn, city_id: self.cityId, blood_id: self.rowofBlood, amount: self.numOfBags)
    }
    //MARK: - Actions
    @IBAction func sendRequestBtnTapped(_ sender: UIButton) {
        if let bloodType = self.bloodTypeTextField.text ,!bloodType.isEmpty ,let bloodBag = self.bloodBagsTextField.text ,!bloodBag.isEmpty{
            self.orderRequest()
            //            self.buyBlood()
            self.canBuyBlood.showBulletin(above: self)
        }else{
            self.cantBuyBlood.showBulletin(above: self)
        }
    }
}
//MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension BuyBloodViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 0:
            return arrOfBlood.count
        case 1:
            return Arrays.arrOfNumber.count
        case 2:
            return self.arrOfAvailableBloodCitiesName.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 0:
            return arrOfBlood[row].name
        case 1:
            return Arrays.arrOfNumber[row]
        case 2:
            return arrOfAvailableBloodCitiesName[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 0:
            bloodTypeTextField.text = arrOfBlood[row].name
            self.rowofBlood = arrOfBlood[row].id
            placeChoiseTF.text = ""
            print("row of blood : \(rowofBlood)")
            self.getAllAvailableBloodPlacesInCountry()
            self.getCityIdOfAvailableBloodPlace()
            self.BloodInfo()
            self.getDelivered_place()
            //            searchInOtherGov()
            print("city id is = \(self.cityId!)")
            //            print("final hospital is = \(self.finalIdOfHospial!)")
            self.bloodTypeTextField.endEditing(true)
            //            print(self.final_place_id ?? "error in final place")
           
            self.getIdOfAvailableBlood()
        case 1:
            bloodBagsTextField.text = Arrays.arrOfNumber[row]
            self.numOfBags = Arrays.arrOfNumber[row]
            self.changePriceWithNumOfBags()
        case 2:
            if arrOfAvailableBloodCitiesName.count == 0{
               
                self.placeChoiseTF.isEnabled = false
                self.placeChoiseTF.placeholder = "لم يتوفر مكان حتي الان لشراء الدم"
            }else{
                self.orderRequestBtn.isEnabled = true
                self.placeChoiseTF.isEnabled = true
                placeChoiseTF.text = arrOfAvailableBloodCitiesName[row]
                print(self.arrOfAvailableBloodCitiesIds[row])
                self.idOfHospital = arrOfAvailableBloodCitiesIds[row]
                self.finalIdOfHospial = self.arrOfAvailableBloodCitiesIds[row]
                print(self.finalIdOfHospial ?? "error in selected id pf hospital:.:(")
                findingBloodError.text = ""
                self.getIdOfAvailableBlood()
            }
        default:
            return
        }
    }
}
