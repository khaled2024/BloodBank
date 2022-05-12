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
            print(self.cityId!)
        }
        //data
        self.getBlood()
        self.BloodInfo()
        searchInOtherCities()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    
    //MARK: - private func
    private func setUp(){
        let bloodTypePickerView = UIPickerView()
        let bloodBagsPickerView = UIPickerView()
        bloodBagsTextField.inputView = bloodBagsPickerView
        bloodTypeTextField.inputView = bloodTypePickerView
        bloodBagsPickerView.delegate = self
        bloodBagsPickerView.dataSource = self
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        bloodBagsPickerView.tag = 1
        bloodTypePickerView.tag = 0
    }
    private func setUpDesign(){
        self.findingBloodError.isHidden = true
        navBar.setNavBar(myView: self, title: "Buy Blood".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
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
                        }
                    }
                    self.cityId = otherCity
                }
                print(self.idOfHospital!)
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
                        break
                    }
                    if idOfHospital != blood.hospital_id || self.rowofBlood != blood.blood_type_id || self.numOfBags > blood.amount{
                        self.findingBloodError.isHidden = false
                        self.findingBloodError.text = "لم يتم العثور علي فصيله دم من نوع \(self.bloodTypeTextField.text!) بالقرب منك :("
                        self.orderRequestBtn.isEnabled = false
                        
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
                print(self.arrOfOtherCities)
            }
        }
    }
    private func orderRequest(){
        ApiService.sharedService.orderBlood(p_ssn: self.p_ssn, blood_type: self.rowofBlood, delivered_place: self.finalIdOfHospial, amount: self.numOfBags)
        let updatedAmount: Int = Int(self.amount)! - Int(self.numOfBags)!
        ApiService.sharedService.updateOrderBlood(amount: String(updatedAmount))
    }
    //MARK: - Actions
    @IBAction func sendRequestBtnTapped(_ sender: UIButton) {
        if let bloodType = self.bloodTypeTextField.text ,!bloodType.isEmpty ,let bloodBag = self.bloodBagsTextField.text ,!bloodBag.isEmpty{
            self.orderRequest()
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
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 0:
            bloodTypeTextField.text = arrOfBlood[row].name
            self.rowofBlood = arrOfBlood[row].id
            print("row of blood : \(rowofBlood)")
            self.BloodInfo()
            self.getDelivered_place()
            self.bloodTypeTextField.endEditing(true)
           
        case 1:
            bloodBagsTextField.text = Arrays.arrOfNumber[row]
            self.numOfBags = Arrays.arrOfNumber[row]
            self.changePriceWithNumOfBags()

        default:
            return
        }
    }
}
