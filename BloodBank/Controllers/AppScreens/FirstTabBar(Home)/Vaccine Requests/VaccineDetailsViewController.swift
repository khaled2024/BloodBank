//
//  VaccineDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/04/2022.
//

import UIKit
import BLTNBoard
import Alamofire

class VaccineDetailsViewController: UIViewController, UISheetPresentationControllerDelegate {
    //MARK: - outlets
    //labels
    @IBOutlet weak var countryVaccineLbl: UILabel!
    @IBOutlet weak var vaccineOriginLbl: UILabel!
    @IBOutlet weak var tradeVaccineNameLbl: UILabel!
    @IBOutlet weak var vaccineNameLbl: UILabel!
    //textFields
    @IBOutlet weak var totalPrice: UITextField!
    @IBOutlet weak var backageAmount: UITextField!
    @IBOutlet weak var backagePrice: UITextField!
    //views
    @IBOutlet weak var buyVaccineView: UIView!
    @IBOutlet weak var vaccineCountryView: UIView!
    @IBOutlet weak var vaccineOriginView: UIView!
    @IBOutlet weak var vaccineTradeNameView: UIView!
    @IBOutlet weak var VaccineNameView: UIView!
    @IBOutlet weak var sendOrderVaccineBtn: UIButton!
    @IBOutlet weak var vaccineBgImage: UIImageView!
    //MARK: - Variabels
    let customView = CustomView()
    var myVaccine: VaccineData!
    var randomNum: Int!
    var amountNum: Int!
    var price: Int!
    let backageAmountPicker = UIPickerView()
    let def = UserDefaults.standard
    var cityId: String!
    var p_ssn: String!
    var vaccinePlaceId: String!
    var delivered_Vaccine_Place: String!
    var vaccineIdSelected: String!
    var arrOfPlaces: [placesData] = [placesData]()
    var arrOfavailableVaccines: [AvailableVaccineData] = [AvailableVaccineData]()
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    private lazy var vaccineAvailable: BLTNItemManager = {
        let item = BLTNPageItem(title: "Congratulation")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"تم تقديم طلبك بنجاح" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true)
            self.dismissVC()
            
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    private lazy var vaccineNotAvailable: BLTNItemManager = {
        let item = BLTNPageItem(title: "Sorry")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"هذا اللقاح غير متوفر حاليا وسيتم تقديم طلبك والرد عليك لاحقا" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true)
            self.dismissVC()
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    //MARK: - LifeCycle
    private func dismissVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSheetPresentation()
        setUpData()
       
        self.backageAmount.inputView = backageAmountPicker
        backageAmountPicker.delegate = self
        backageAmountPicker.dataSource = self
        self.amountNum = Int(backageAmount.text!)
        print(amountNum!)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpViews()
        backagePrice.isUserInteractionEnabled = false
        totalPrice.isUserInteractionEnabled = false
        sendOrderVaccineBtn.customTitleLbl(btn: sendOrderVaccineBtn, text: "ارسال الطلب", fontSize: 17)
        self.animated()
    }
    
    
    //MARK: - Functions
    private func setUpData(){
        let amount = myVaccine.amount
        let amountInt = Int(amount)
        let price = myVaccine.price
        self.price = Int(price)
        let priceInt = Int(price)
        let total = amountInt! * priceInt!
        self.vaccineBgImage.image = UIImage(named: "vaccineImage\(randomNum!)")
        self.vaccineNameLbl.text = myVaccine.scientific_name
        self.tradeVaccineNameLbl.text = myVaccine.trade_name
        self.vaccineOriginLbl.text = myVaccine.hospital_name // vaciinee place_id
        self.countryVaccineLbl.text = myVaccine.country_name
        self.backagePrice.text = String(myVaccine.price)
        self.totalPrice.text = String(total)
        self.backageAmount.text = myVaccine.amount
        self.vaccineIdSelected = myVaccine.vaccine_id
        print(" vaccine id : \(vaccineIdSelected ?? "")")
        if let user = def.object(forKey: "userInfo")as? [String]{
            print("Order sent succesfully.")
            self.cityId = user[12]
            self.p_ssn = user[0]
            print("cityId:\(self.cityId!) , p_ssn: \(self.p_ssn!)")
        }
        self.getDeliveredPlace()
        
    }
    private func getDeliveredPlace(){
        ApiService.sharedService.getDonatePlace { error, places in
            if let error = error {
                print(error.localizedDescription)
            }else if let places = places {
                self.arrOfPlaces = places
                for place in self.arrOfPlaces{
                    if self.cityId == place.city_id{
                        self.vaccinePlaceId =  place.id
                        print( "vaccine place :\(self.vaccinePlaceId ?? "") ")
                    }else{
                        print("There is Not places with this CityID\(self.cityId ?? "")")
                    }
                }
            }
            
        }
        ApiService.sharedService.availableVaccine { error, availablevaccine in
            if let error = error {
                print(error.localizedDescription)
            }else if let availablevaccine = availablevaccine {
                self.arrOfavailableVaccines = availablevaccine
                for availVaccine in self.arrOfavailableVaccines{
                    if self.vaccinePlaceId == availVaccine.vaccine_place_id && self.vaccineIdSelected == availVaccine.vaccine_id{
                        self.delivered_Vaccine_Place = availVaccine.vaccine_place_id
                        print(" vaccinePlace \(availVaccine.vaccine_place_id) ,vaccineId \( availVaccine.vaccine_id) , vaccineCountry \(availVaccine.country_id) , vaccineAmount \(availVaccine.amount) , vaccine price \(availVaccine.price)")
                    }else{
                        print("This vaccine dosnt available with is vaccine Place \(self.self.vaccinePlaceId ?? "" )")
                    }
                }
            }
        }
    }
    private func sendVaccineOrder()-> Bool{
        if let vaccinePlace = self.delivered_Vaccine_Place , !vaccinePlace.isEmpty{
            ApiService.sharedService.addOrderVaccine(vaccineID: self.myVaccine.id, delivered_place: vaccinePlace, amount: String(self.amountNum), p_ssn: self.p_ssn)
            return true
        }else{
            return false
        }
    }
    private func animated(){
        UIView.animate(withDuration: 0.5) {
            self.VaccineNameView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.5){
                    self.VaccineNameView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
        
        UIView.animate(withDuration: 0.4) {
            self.vaccineTradeNameView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.4){
                    self.vaccineTradeNameView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.vaccineOriginView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.3){
                    self.vaccineOriginView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
        UIView.animate(withDuration: 0.45) {
            self.vaccineCountryView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.45){
                    self.vaccineCountryView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
    }
   
    private func setUpViews(){
        customView.vaccineCustomView(theView: VaccineNameView)
        customView.vaccineCustomView(theView: vaccineTradeNameView)
        customView.vaccineCustomView(theView: vaccineOriginView)
        customView.vaccineCustomView(theView: vaccineCountryView)
        customView.vaccineCustomView(theView: buyVaccineView)
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
    private func isVaccineIsAvailable()-> Bool{
        if let backagePrice = self.backagePrice.text , !backagePrice.isEmpty , let backageNumber = self.backageAmount.text , !backageNumber.isEmpty , let totalPrice = self.totalPrice.text, !totalPrice.isEmpty, sendVaccineOrder(){
            return true
        }else{
            return false
        }
    }
    private func orderVaccine(){
        if isVaccineIsAvailable(){
            UIView.animate(withDuration: 0.4) {
                self.buyVaccineView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
            } completion: { completed in
                if completed{
                    UIView.animate(withDuration: 0.4){
                        self.buyVaccineView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.vaccineAvailable.showBulletin(above: self)
                        }
                    }
                }
            }
        }else{
            UIView.animate(withDuration: 0.4) {
                self.buyVaccineView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
            } completion: { completed in
                if completed{
                    UIView.animate(withDuration: 0.4){
                        self.buyVaccineView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.vaccineNotAvailable.showBulletin(above: self)
                        }
                    }
                }
            }
        }
    }
    //MARK: - Actions
    @IBAction func ViewsTapped(_ sender: UITapGestureRecognizer) {
        self.animated()
    }
    @IBAction func orderVaccineBtnTapped(_ sender: UIButton) {
        self.orderVaccine()
    }
}
//MARK: - Extensions
extension VaccineDetailsViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Arrays.arrOfNumber.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Arrays.arrOfNumber[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        backageAmount.text = Arrays.arrOfNumber[row]
        self.amountNum = Int(Arrays.arrOfNumber[row])
        totalPrice.text = String(amountNum * self.price)
        
    }
}
