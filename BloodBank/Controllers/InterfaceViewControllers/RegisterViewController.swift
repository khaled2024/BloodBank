//
//  RegisterViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Outlets
    
    //tf
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var fNumberTextField: UITextField!
    @IBOutlet weak var sNumberTextField: UITextField!
    @IBOutlet weak var governmentTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    // views
    @IBOutlet weak var viewOfContents: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var familyNameView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var fNumView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var bloodTypeView: UIView!
    @IBOutlet weak var birthDateView: UIView!
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var sNumView: UIView!
    @IBOutlet weak var govView: UIView!
    //btn
    @IBOutlet weak var goToSecondViewBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var backToFirstView: UIButton!
    //MARK: - variables
    private let BloodTypePicker = UIPickerView()
    private var arrayOfBloodType = Arrays.arrayOfBloodType
    var customBtn = UserCustomBtn()
    var customTF = UserCustomTF()
    let customView = CustomView()
    var gradientBackground = UserGradientBackground()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPicker()
        self.firstView.isHidden = false
        self.secondView.isHidden = true
        self.goToSecondViewBtn.customTitleLbl(btn: goToSecondViewBtn, text: "استمرار", fontSize: 16)
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
        setNavBar()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    //MARK: - Private functions
    private func bloodType()-> String?{
        if let userBloodType = self.bloodTypeTextField.text{
            let bloodType = Arrays.dicOfBloodType[userBloodType]
            return bloodType
        }
        return nil
    }
    private func addUserData(){
        //        let date = Date()
        //        let df = DateFormatter()
        //        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        let dateString = df.string(from: date)
        ApiService.sharedService.addUserData(email: emailTextField.text!, fName: nameTextField.text!, lName: familyNameTextField.text!, id: IDTextField.text!, password: passwordTextField.text!, fPhone: fNumberTextField.text!,sPhone: sNumberTextField.text!, bloodType: self.bloodType()! ,governrate: governmentTextField.text! , city: cityTextField.text!,birthDay: birthDayTextField.text!, gender: genderTextField.text!)
    }
    private func setNavBar(){
        let navBar = NavigationBar()
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.918268621, green: 0.2490310073, blue: 0.3684441447, alpha: 1),.font: UIFont(name: "Almarai-Bold", size: 25)!]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8666378856, green: 0.2537421584, blue: 0.3427102566, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white ,.font: UIFont(name: "Almarai-Bold", size: 18)!]
        navBar.setNavBar(myView: self, title: "انشاء حساب جديد", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    private func setUpPicker(){
        BloodTypePicker.tag = 1
        BloodTypePicker.delegate = self
        BloodTypePicker.dataSource = self
        bloodTypeTextField.inputView = BloodTypePicker
    }
    private func setUpDesign(){
        customBtn.confirmBtnSelected(Btn: goToSecondViewBtn)
        customBtn.confirmBtnSelected(Btn: confirmBtn)
        customView.signUpView(theView: self.firstView)
        customView.signUpView(theView: self.secondView)
    }
    private func checkPassword()->Bool{
        if let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    private func checkTextFields()-> Bool{
        if let email = emailTextField.text , !email.isEmpty , let name = nameTextField.text , !name.isEmpty,let familyName = familyNameTextField.text , !familyName.isEmpty , let ID = IDTextField.text , !ID.isEmpty , let fPhone = fNumberTextField.text , !fPhone.isEmpty, let sPhone = sNumberTextField.text, !sPhone.isEmpty , let bloodType = bloodTypeTextField.text , !bloodType.isEmpty, let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , let gov = governmentTextField.text , !gov.isEmpty, let city = cityTextField.text , !city.isEmpty, let birthDay = birthDayTextField.text , !birthDay.isEmpty , let gender = genderTextField.text , !gender.isEmpty{
            return true
        }else{
            return false
        }
    }
    private func checkValidationTextField() throws {
        if let email = emailTextField.text , let firstName = nameTextField.text ,let familyName = familyNameTextField.text , let ID = IDTextField.text ,  let fPhone = fNumberTextField.text , let sPhone = sNumberTextField.text,  let bloodType = bloodTypeTextField.text ,let password = passwordTextField.text ,  let confirmPassword = confirmPasswordTextField.text , let gov = governmentTextField.text , let city = cityTextField.text, let birthDay = birthDayTextField.text ,  let gender = genderTextField.text {
//            if !email.isValidEmail{
//                throw SignUpError.isValidEmail
//            }
//            if !firstName.isValidName{
//                throw SignUpError.isValidName
//            }
//            if !familyName.isValidName{
//                throw SignUpError.isValidName
//            }
//            if !ID.isValidID{
//                throw SignUpError.isValidID
//            }
//            if !password.isValidPassword{
//                throw SignUpError.isValidPassword
//            }
//            if !confirmPassword.isValidPassword{
//                throw SignUpError.isValidPassword
//            }
//            if password != confirmPassword {
//                showNormalAlert(title: "Sorry", message: "please check the password")
//            }
//            if !fPhone.isValidMobile{
//                throw SignUpError.isValidMobile
//            }
//            if !sPhone.isValidMobile{
//                throw SignUpError.isValidMobile
//            }
//            if gov.isEmpty{
//                showNormalAlert(title: "Sorry", message: "please check your Governrate")
//            }
//            if city.isEmpty{
//                showNormalAlert(title: "Sorry", message: "please check the Address")
//            }
//            if bloodType.isEmpty{
//                showNormalAlert(title: "Sorry", message: "please check the Blood type")
//            }
//            if birthDay.isEmpty{
//                showNormalAlert(title: "Sorry", message: "please check your Birth Date")
//            }
//            if gender.isEmpty{
//                showNormalAlert(title: "Sorry", message: "please check your Gender")
//            }
            if !checkTextFields(){
                showNormalAlert(title: "", message: "Please Fill All fields")
            }
            self.animateButtons()
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.SuccessAlert(title: "Congratulation", message: "Your Account Created Succesfully", style: .default) { _ in
                    self.animateButtons()
                    self.goToLoginScreen()
                    self.addUserData()
                }
            }
        }
    }
    private func checkAllFields(){
        if checkPassword() && checkPassword(){
            self.animateButtons()
            customBtn.toggleForBtn(Btn: self.confirmBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.SuccessAlert(title: "Congratulation", message: "Your Account Created Succesfully", style: .default) { _ in
                    self.animateButtons()
                    self.goToLoginScreen()
                }
            }
        }else{
            self.showNormalAlert(title: "Sorry", message: "Please Check your password")
        }
    }
    private func goToLoginScreen(){
        let loginScreen = LoginViewController.instantiate()
        navigationController?.pushViewController(loginScreen, animated: true)
    }
    func animate(theview: UIView){
        UIView.transition(with: theview, duration: 1, options: [.transitionFlipFromRight], animations: {
            theview.alpha = 0.0
        }, completion: {_ in
            theview.isHidden = true
        })
    }
    private func animateButtons(){
        UIView.animate(withDuration: 0.5) {
            self.confirmBtn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
            self.goToSecondViewBtn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.5) {
                    self.confirmBtn.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    self.goToSecondViewBtn.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
    }
    //MARK: - Actions
    @IBAction func backToFirstViewBtnTapped(_ sender: UIButton) {
        self.animate(theview: self.secondView)
        self.firstView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.firstView.alpha = 1
        }
    }
    @IBAction func goToSecondView(_ sender: UIButton) {
        animate(theview: firstView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.secondView.isHidden = false
            self.secondView.alpha = 1
        }
    }
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        //        checkAllFields()
        do {
            try checkValidationTextField()
        }catch SignUpError.isValidEmail{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Email")
        }catch SignUpError.isValidID{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid ID")
        } catch SignUpError.isValidName{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Name")
        }catch SignUpError.isValidPassword{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Password")
        }catch SignUpError.isValidMobile{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Mobile")
        }catch {
            showNormalAlert(title: "Sorry", message: "Please Fill All fields")
        }
    }
}
//MARK: - UIPickerViewDelegate,UIPickerViewDataSource
extension RegisterViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfBloodType.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bloodTypeTextField.text = arrayOfBloodType[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayOfBloodType[row]
    }
    
}
