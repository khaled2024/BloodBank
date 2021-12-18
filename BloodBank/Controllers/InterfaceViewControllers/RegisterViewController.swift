//
//  RegisterViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var viewOfContents: UIView!
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
    
    //MARK: - variables
    private let BloodTypePicker = UIPickerView()
    private let GenderPicker = UIPickerView()
    private let GovernmentPicker = UIPickerView()
    private let CityPicker = UIPickerView()
    
    private var arrayOfBloodType = Arrays.arrayOfBloodType
    private var arrayOfGender = Arrays.arrayOfGender
    
    private var arrayOfgover: [Government] = []
    private var arrayOfcity: [City] = []
    private var GovernmentIndex = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpPicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        setGradientBackground2()
        UserCustomBtn.shared().confirmBtnNotSelected(Btn: ConfirmBtn)
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
        let colorTop =  #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    private func setGradientBackground2() {
        let colorTop = #colorLiteral(red: 0.9669746757, green: 0.3849074841, blue: 0.4152426124, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.viewOfContents.bounds
        self.viewOfContents.layer.insertSublayer(gradientLayer, at:0)
    }
    private func setUpTextField(textField: UITextField , nameTextField: String){
        self.textFieldBorder(textField: textField, nameeditText: nameTextField)
        self.setupPadding(for: textField)
    }
    private func textFieldBorder(textField: UITextField , nameeditText: String){
        textField.layer.borderColor = #colorLiteral(red: 0.8716132045, green: 0.8825858235, blue: 0.8823928237, alpha: 1)
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(
            string: nameeditText,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
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
        UserCustomBtn.shared().toggleForBtn(Btn: ConfirmBtn)
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
    
}
