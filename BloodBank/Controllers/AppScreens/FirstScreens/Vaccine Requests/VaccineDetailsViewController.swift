//
//  VaccineDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/04/2022.
//

import UIKit
import BLTNBoard

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
    //MARK: - Variabels
    let customView = CustomView()
    var myVaccine: VaccineItem!
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
            self.dismiss(animated: true) {
//                self.navigationController?.popToRootViewController(animated: true)
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
    private lazy var vaccineNotAvailable: BLTNItemManager = {
        let item = BLTNPageItem(title: "Sorry")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"هذا اللقاح غير متوفر حاليا وسيتم تقديم طلبك والرد عليك لاحقا" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true) {
//                self.navigationController?.popToRootViewController(animated: true)
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
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSheetPresentation()
        setUpData()
        let backageAmountPicker = UIPickerView()
        self.backageAmount.inputView = backageAmountPicker
        backageAmountPicker.delegate = self
        backageAmountPicker.dataSource = self

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
    private func setUpData(){
        self.vaccineNameLbl.text = myVaccine.scienceVaccineName
        self.tradeVaccineNameLbl.text = myVaccine.tradeVaccineName
        self.vaccineOriginLbl.text = myVaccine.vaccineorigin
        self.countryVaccineLbl.text = myVaccine.vaccineCountry
        self.backagePrice.text = String(myVaccine.packagePrice)
        self.totalPrice.text = String(myVaccine.totalPrice)
        self.backageAmount.text = String(myVaccine.packageNumber)

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
        if let backagePrice = self.backagePrice.text , !backagePrice.isEmpty , let backageNumber = self.backageAmount.text , !backageNumber.isEmpty , let totalPrice = self.totalPrice.text , !totalPrice.isEmpty{
            return true
        }else{
            return false
        }
    }
    //MARK: - Actions

    @IBAction func ViewsTapped(_ sender: UITapGestureRecognizer) {
        self.animated()
    }
    @IBAction func orderVaccineBtnTapped(_ sender: UIButton) {
        if isVaccineIsAvailable(){
            UIView.animate(withDuration: 0.4) {
                self.buyVaccineView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1)
            } completion: { completed in
                if completed{
                    UIView.animate(withDuration: 0.4){
                        self.buyVaccineView.layer.transform = CATransform3DMakeScale(1, 1, 1)
                        self.vaccineAvailable.showBulletin(above: self)
                    }
                }
            }
           
        }else{
            self.vaccineNotAvailable.showBulletin(above: self)
        }
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
    }
}
