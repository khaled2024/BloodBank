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
    @IBOutlet weak var diseaseTextField: UITextField!
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
    
    var customBtn = UserCustomBtn()
    var customTF = UserCustomTF()
    var gradientBackground = UserGradientBackground()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpPicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
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
    private func setUpDesign(){
        gradientBackground.setGradientBackground(colorTop: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1), view: view)
        
        gradientBackground.setGradientBackground(colorTop: #colorLiteral(red: 0.9669746757, green: 0.3849074841, blue: 0.4152426124, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1), view: viewOfContents)
        
        customBtn.confirmBtnNotSelected(Btn: ConfirmBtn)
        customTF.setUpTextField(textField: emailTextField, nameTextField: "Enter Your Email")
        customTF.setUpTextField(textField: nameTextField, nameTextField: "Enter Your Name")
        customTF.setUpTextField(textField: IDTextField, nameTextField: "Enter Your National ID")
        customTF.setUpTextField(textField: phoneTextField, nameTextField: "Enter Your Phone")
        customTF.setUpTextField(textField: bloodTypeTextField, nameTextField: "Enter Your Blood Type")
        customTF.setUpTextField(textField: passwordTextField, nameTextField: "Enter Your Password")
        customTF.setUpTextField(textField: confirmPasswordTextField, nameTextField: "Confirm Your Password")
        customTF.setUpTextField(textField: diseaseTextField, nameTextField: "Enter Your disease")
        customTF.setUpTextField(textField: genderTextField, nameTextField: "Enter Your Gender")
        customTF.setUpTextField(textField: ageTextField, nameTextField: "Enter Your Age")
        customTF.setUpTextField(textField: governmentTextField, nameTextField: "Enter Your Government")
        customTF.setUpTextField(textField: cityTextField, nameTextField: "Enter Your City")
    }
    private func checkPassword()->Bool{
        if let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    private func checkTextFields()-> Bool{
        if let email = emailTextField.text , !email.isEmpty , let name = nameTextField.text , !name.isEmpty , let ID = IDTextField.text , !ID.isEmpty , let phone = phoneTextField.text , !phone.isEmpty , let bloodType = bloodTypeTextField.text , !bloodType.isEmpty, let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , let disease = diseaseTextField.text , !disease.isEmpty , let gender = genderTextField.text , !gender.isEmpty , let age = ageTextField.text , !age.isEmpty , let gov = governmentTextField.text , !gov.isEmpty , let city = cityTextField.text , !city.isEmpty  {
            
            return true
        }else{
            return false
        }
    }
    private func goToLoginScreen(){
        let loginScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
        navigationController?.pushViewController(loginScreen, animated: true)
    }
    //MARK: - Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        if checkTextFields() {
        }else{
            self.showAlert(title: "Sorry", message: "Please fill the all fields")
        }
        if checkPassword(){
            customBtn.toggleForBtn(Btn: self.ConfirmBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.goToLoginScreen()
                self.showAlert(title: "congratulations", message: "Your Account Created Succesfully")
            }
        }else{
            self.showAlert(title: "Sorry", message: "Please Check your password")
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
