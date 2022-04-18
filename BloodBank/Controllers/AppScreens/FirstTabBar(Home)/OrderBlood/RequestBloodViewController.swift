//
//  RequestBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class RequestBloodViewController: UIViewController{
    
    //MARK: - outlets
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var numOfUnitsLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bloodTypePicker: UIPickerView!
    @IBOutlet weak var bloodBankNameTF: UITextField!
    @IBOutlet weak var bloodQuantitySlider: UISlider!
    
    let navBar = NavigationBar()
    let customBtn = UserCustomBtn()
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
    }
    //MARK: - private func
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "انشاء طلب دم", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        self.navigationController?.navigationBar.isHidden = false
    }
    private func setUp(){
        bloodTypePicker.delegate = self
        bloodTypePicker.dataSource = self
        datePicker.preferredDatePickerStyle = .automatic
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        nextBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        datePicker.date = .now
    }
    
    @objc func dateSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        self.date = dateFormatter.string(from: datePicker.date)
        print((date ?? "") )
    }
    private func checkDate()-> Bool{
        if let time = self.date , !time.isEmpty {
            print("the time is \(time)")
            return true
        }
        showNormalAlert(title: "Sorry", message: "Please Choose the date.")
        return false
    }
    private func checkGoingNextRequest(){
        if let bloodBankName = bloodBankNameTF.text , !bloodBankName.isEmpty , let unit = numOfUnitsLbl.text , !unit.isEmpty, checkDate(){
            nextBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.3843137255, alpha: 1)
            let selectedValue = Arrays.arrayOfBloodType[bloodTypePicker.selectedRow(inComponent: 0)]
            let controller = SecondRequestBloodViewController.instantiate()
            self.navigationController?.pushViewController(controller, animated: true)
            controller.sick = Sick(bloodType: selectedValue, address: self.bloodBankNameTF.text, time: self.date, quantity: self.numOfUnitsLbl.text)
            print("blood type is \(Arrays.arrayOfBloodType[bloodTypePicker.selectedRow(inComponent: 0)])")
            print("name of hospital is \(bloodBankNameTF.text!)")
            print("the quantity is \(numOfUnitsLbl.text!)")
        }else{
            self.showNormalAlert(title: "Sorry", message: "Please fill Fields.")
            customBtn.confirmBtnNotSelected(Btn: nextBtn)
        }
    }
    
    //MARK: - actions
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        checkGoingNextRequest()
    }
    @IBAction func numOfUnitsTapped(_ sender: UISlider) {
        let units = round(sender.value )
        numOfUnitsLbl.text = String("\(units) وحده")
    }
}

//MARK: - extenison
extension RequestBloodViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Arrays.arrayOfBloodType.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Arrays.arrayOfBloodType[row]
    }
}

