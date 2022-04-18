//
//  PickDateTimeViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 08/03/2022.
//

import UIKit

class PickDateTimeViewController: UIViewController {
    
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var confirmDateBtn: UIButton!
    let navBar = NavigationBar()
    let bloodTypePickerView = UIPickerView()
    let cityPickerView = UIPickerView()
    let arrOfBloodType = Arrays.arrayOfBloodType
    let arrOfCities = Arrays.arrayOfHospitals

    
    //MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        setUp()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        confirmDateBtn.backgroundColor =  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    //MARK: - private functions
    private func setUp(){
        bloodTypePickerView.tag = 0
        cityPickerView.tag = 1
        cityTextField.inputView = cityPickerView
        bloodTypeTextField.inputView = bloodTypePickerView
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
    private func setUpDesign(){
        title = "حدد الوقت والتاريخ"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.isEnabled = false
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    private func setUpTF()-> Bool{
        if let dateLbl = dateTimeLabel.text , !dateLbl.isEmpty ,let city = cityTextField.text , !city.isEmpty , let blood = bloodTypeTextField.text , !blood.isEmpty {
                return true
        }
        return false
    }
    //MARK: - Actions
    private func openSheet(){
        let sheetPresentationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SheetViewController")as! SheetViewController
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
    @objc func dateSelected(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        let date = dateFormatter.string(from: datePicker.date)
        dateTimeLabel.text = date
        self.confirmDateBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
    
    @IBAction func confirmDateBtnTapped(_ sender: UIButton) {
        if setUpTF(){
            openSheet()
        }else{
            self.confirmDateBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
extension PickDateTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 0 :
            return arrOfBloodType.count
        case 1 :
            return arrOfCities.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 0 :
            return arrOfBloodType[row]
        case 1 :
            return arrOfCities[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 0 :
            bloodTypeTextField.text = arrOfBloodType[row]
        case 1 :
            cityTextField.text = arrOfCities[row]
        default:
            return
        }
    }
}
//
//DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//
//}
