//
//  PickDateTimeViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 08/03/2022.
//

import UIKit

class PickDateTimeViewController: UIViewController {
    
    
    @IBOutlet weak var addressOfHospital: UILabel!
    @IBOutlet weak var govTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var confirmDateBtn: UIButton!
    let navBar = NavigationBar()
    let bloodTypePickerView = UIPickerView()
    let cityPickerView = UIPickerView()
    let govPickerView = UIPickerView()
    var userBloodType: String = ""
    var user_Pssn: String = ""
    let arrOfBloodType = Arrays.arrayOfBloodType
    let arrOfCities = Arrays.arrayOfCities
    let arrOfGov = Arrays.arrayOfGover
    let def = UserDefaults.standard
    var HospitalName: String = ""
    var userCityId: String = ""
    var userHospitalId: String = ""
    var userGovName: String = ""
    var userCityName: String = ""
    //MARK: - life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        setUp()
        addressOfHospital.text = HospitalName
        print(userCityId)
        print(userHospitalId)
        print(userGovName)
        print(userCityName)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //MARK: - private functions
    private func setUp(){
        bloodTypePickerView.tag = 0
        govPickerView.tag = 1
        cityPickerView.tag = 2
        govTextField.inputView = govPickerView
        cityTextField.inputView = cityPickerView
        bloodTypeTextField.inputView = bloodTypePickerView
        govPickerView.delegate = self
        govPickerView.dataSource = self
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        datePicker.preferredDatePickerStyle = .inline
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        self.textFieldsData()
    }
    private func textFieldsData(){
        //blood type & p_ssn & city & gov
        self.bloodTypeTextField.isUserInteractionEnabled = false
        self.bloodTypeTextField.backgroundColor = .lightGray.withAlphaComponent(0.6)
        self.govTextField.isUserInteractionEnabled = false
        self.govTextField.backgroundColor = .lightGray.withAlphaComponent(0.6)
        self.cityTextField.isUserInteractionEnabled = false
        self.cityTextField.backgroundColor = .lightGray.withAlphaComponent(0.6)
        if let user = def.object(forKey: "userInfo")as? [String]{
            self.userBloodType = user[9]
            self.user_Pssn = user[0]
        }
        self.bloodTypeTextField.text = self.userBloodType
        self.govTextField.text = self.userGovName
        self.cityTextField.text = self.userCityName
    }
    private func setUpDesign(){
        title = "حدد الوقت والتاريخ"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  UIColor(named: "viewbgColor")
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.isEnabled = false
//        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    private func setUpTF()-> Bool{
        if let dateLbl = dateTimeLabel.text , !dateLbl.isEmpty ,let city = cityTextField.text , !city.isEmpty , let blood = bloodTypeTextField.text , !blood.isEmpty, let gov = govTextField.text , !gov.isEmpty {
                return true
        }
        return false
    }
    private func addBloodDonation(){
        ApiService.sharedService.addBloodDonation(p_ssn: self.user_Pssn, city_id: self.userCityId, donate_place_id: self.userHospitalId, time: self.dateTimeLabel.text!)
    }
    private func addToLastDonate(){
        ApiService.sharedService.addLastDonate(p_ssn: self.user_Pssn, donate_place_id: self.userHospitalId, time: self.dateTimeLabel.text!)
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = Locale(identifier: "en")
        let date = dateFormatter.string(from: datePicker.date)
        dateTimeLabel.text = date
        self.confirmDateBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
    
    @IBAction func confirmDateBtnTapped(_ sender: UIButton) {
        if setUpTF(){
            self.addBloodDonation()
            self.addToLastDonate()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.openSheet()
            }
        }else{
            showNormalAlert(title: "Sorry", message: "Please Fill All Fields.")
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
            return arrOfGov.count
        case 2 :
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
            return arrOfGov[row]
        case 2 :
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
            govTextField.text = arrOfGov[row]
        case 2 :
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
