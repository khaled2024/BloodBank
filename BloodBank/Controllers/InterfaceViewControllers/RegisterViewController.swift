//
//  RegisterViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var governmentTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    //MARK: - variable
    private let BloodTypePicker = UIPickerView()
    private let GenderPicker = UIPickerView()
    private let GovernmentPicker = UIPickerView()
    private let CityPicker = UIPickerView()
    
    private var arrayOfBloodType = ["","A+","A-","B+","B-","AB+","AB-","O+","O-"]
    private var arrayOfGender = ["","Male","Female"]
    
    private var arrayOfgover: [Government] = []
    private var arrayOfcity: [City] = []
    private var GovernmentIndex = 0
    
    var checkConfirmBtn = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        confirmBtnNotSelected()
        //        setGradientBackground()
        setUpTextField(textField: emailTextField, nameTextField: "Enter Your Email")
        setUpTextField(textField: nameTextField, nameTextField: "Enter Your Name")
        setUpTextField(textField: IDTextField, nameTextField: "Enter Your National ID")
        setUpTextField(textField: phoneTextField, nameTextField: "Enter Your Phone")
        setUpTextField(textField: bloodTypeTextField, nameTextField: "Enter Your Blood Type")
        setUpTextField(textField: passwordTextField, nameTextField: "Enter Your Password")
        setUpTextField(textField: confirmPasswordTextField, nameTextField: "Confirm Your Password")
        setUpTextField(textField: genderTextField, nameTextField: "Enter Your Gender")
        setUpTextField(textField: ageTextField, nameTextField: "Enter Your Age")
        setUpTextField(textField: governmentTextField, nameTextField: "Enter Your Government")
        setUpTextField(textField: cityTextField, nameTextField: "Enter Your City")
    }
    
    //MARK: - Private functions
    private func confirmBtnNotSelected(){
        ConfirmBtn.tintColor = .white
        ConfirmBtn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    private func confirmBtnSelected(){
        ConfirmBtn.tintColor = .white
        ConfirmBtn.backgroundColor = #colorLiteral(red: 0.9258500934, green: 0.1487901807, blue: 0.03288665786, alpha: 1)
    }
    private func setUpPicker(){
        BloodTypePicker.tag = 1
        GenderPicker.tag = 2
        GovernmentPicker.tag = 3
        CityPicker.tag = 4
        BloodTypePicker.delegate = self
        BloodTypePicker.dataSource = self
        GenderPicker.delegate = self
        GenderPicker.dataSource = self
        GovernmentPicker.delegate = self
        GovernmentPicker.dataSource = self
        CityPicker.delegate = self
        CityPicker.dataSource = self
        bloodTypeTextField.inputView = BloodTypePicker
        genderTextField.inputView = GenderPicker
        governmentTextField.inputView = GovernmentPicker
        cityTextField.inputView = CityPicker
    }
    private func setUpData(){
        let tanta = City(name: "Tanat", governmentId: 1)
        let zefta = City(name: "Zefta", governmentId: 1)
        
        let naserCity = City(name: "NaserCity", governmentId: 2)
        
        let Garpia = [tanta,zefta]
        let Cairo = [naserCity]
        
        
        let garpia = Government(id: 1, name: "Garpia", city: Garpia)
        let cairo = Government(id: 2, name: "Cairo", city: Cairo)
        
        
        self.arrayOfgover = [garpia,cairo]
    }
    
    private func setGradientBackground() {
        let colorTop =  UIColor(red: 0.86, green: 0.24, blue: 0.00, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.85, green: 0.48, blue: 0.46, alpha: 1.00).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    private func setUpTextField(textField: UITextField , nameTextField: String){
        self.textFieldBorder(textField: textField, nameeditText: nameTextField)
        self.setupPadding(for: textField)
    }
    private func textFieldBorder(textField: UITextField , nameeditText: String){
        textField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(
            string: nameeditText,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)]
        )
    }
    private func setupPadding(for textField: UITextField){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }
    //MARK: - Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        if checkConfirmBtn == false{
            checkConfirmBtn = true
            confirmBtnSelected()
        }else{
            checkConfirmBtn = false
            confirmBtnNotSelected()
        }
    }
}
//MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension RegisterViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return arrayOfBloodType.count
        case 2:
            return arrayOfGender.count
        case 3:
            return arrayOfgover.count
        default:
            return arrayOfgover[GovernmentIndex].city.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return arrayOfBloodType[row]
        case 2:
            return arrayOfGender[row]
        case 3:
            return arrayOfgover[row].name
        default:
            return arrayOfgover[GovernmentIndex].city[row].name
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            bloodTypeTextField.text = arrayOfBloodType[row]
        case 2:
            genderTextField.text = arrayOfGender[row]
        case 3:
            governmentTextField.text = arrayOfgover[row].name
            self.GovernmentIndex = row
        default:
            cityTextField.text = arrayOfgover[GovernmentIndex].city[row].name
        }
    }
}
