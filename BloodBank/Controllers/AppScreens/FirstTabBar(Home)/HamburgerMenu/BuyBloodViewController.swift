//
//  BuyBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/04/2022.
//

import UIKit
import BLTNBoard

class BuyBloodViewController: UIViewController{
    
    
    @IBOutlet weak var orderRequestBtn: UIButton!
    @IBOutlet weak var bloodBagsTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    let navBar = NavigationBar()
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
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
        navBar.setNavBar(myView: self, title: "Buy Blood".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    
    //MARK: - Actions
    
    @IBAction func sendRequestBtnTapped(_ sender: UIButton) {
        if let bloodType = self.bloodTypeTextField.text ,!bloodType.isEmpty ,let bloodBag = self.bloodBagsTextField.text ,!bloodBag.isEmpty{
            self.canBuyBlood.showBulletin(above: self)
        }else{
            self.cantBuyBlood.showBulletin(above: self)
        }
    }
}
extension BuyBloodViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 0:
            return Arrays.arrayOfBloodType.count
        case 1:
            return Arrays.arrOfNumber.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 0:
            return Arrays.arrayOfBloodType[row]
        case 1:
            return Arrays.arrOfNumber[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 0:
            bloodTypeTextField.text = Arrays.arrayOfBloodType[row]
        case 1:
            bloodBagsTextField.text = Arrays.arrOfNumber[row]
        default:
            return
        }
    }
}
