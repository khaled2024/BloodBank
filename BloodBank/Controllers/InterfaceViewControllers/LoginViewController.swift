//
//  LoginViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit
class LoginViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var signInView: UIView!
    //MARK: - Variables
    var gradientBackground = UserGradientBackground()
    var customTF = UserCustomTF()
    let customView = CustomView()
    var customBtn = UserCustomBtn()
    let navigationManager = NavigationManager()
    let navBar = NavigationBar()
    var arrOfUser: [userData] = [userData]()
    var arrOfUserData = [String]()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        customBtn.confirmBtnNotSelected(Btn: loginBtn)
        customBtn.confirmBtnSelected(Btn: loginBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    //MARK: -  private functions
    private func setUpDesign(){
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        customView.signUpView(theView: signInView)
        
    }
    private func goToMainScreen(){
        navigationManager.show(screen: .tapBarController, inController: self)
    }
    private func checkTextFields()-> Bool{
        if let email = emailTextField.text , !email.isEmpty , let password = passwordTextField.text , !password.isEmpty{
            return true
        }else{
            return false
        }
    }
    private func goToRegisterScreen(){
        let registerScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")as! RegisterViewController
        navigationController?.pushViewController(registerScreen, animated: true)
        
    }
    private func animateButtons(){
        UIView.animate(withDuration: 0.5) {
            self.loginBtn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.5) {
                    self.loginBtn.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
    }
    private func checkValidationOfSignIn(){
        ApiService.sharedService.checkSignIn{ error, user in
            var userInfo: String = ""
            if let error = error {
                print(error.localizedDescription)
                self.showNormalAlert(title: "للاسف", message: "لا يمكن اتمام عمليه التسجيل ، لا يمكن الاتصال بالخادم :(")
            }else if let user = user {
                self.arrOfUser = user
            }
            for user in self.arrOfUser {
                if user.email == self.emailTextField.text && user.password == (self.passwordTextField.text?.sha1()){
                    userInfo = "User info: \(user.p_ssn) \( user.p_first_name) \( user.p_last_name) \(user.mobile_phone) \(user.blood_type) \(user.password) \(user.email) \(user.city_id) \(user.governorate_name) \(user.city_name)"
                    print(userInfo)
                    UserDefaults.standard.set([user.p_ssn , user.p_first_name , user.p_last_name,user.email, user.governorate_name, user.city_name,user.mobile_phone,user.home_phone,user.birthday,user.blood_type , user.password , user.gender, user.city_id], forKey: "userInfo")
                    print(user.city_id)
                    print(user.city_name)
                }else{
                }
            }
            if userInfo.isEmpty{
                print("this user dosnt exist............\(self.arrOfUser.indices)")
                self.showNormalAlert(title: "Sorry", message: "Please check your Email or Password ")
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    self.goToMainScreen()
                    print("Login succesully")
                }
            }
            
        }
    }
    private func signIn() throws{
        if let email = emailTextField.text , let password = passwordTextField.text{
            if !email.isValidEmail {
                throw SignUpError.isValidEmail
            }
            if !password.isValidPassword {
                throw SignUpError.isValidPassword
            }else{
                self.animateButtons()
                self.customBtn.confirmBtnSelected(Btn: self.loginBtn)
                self.checkValidationOfSignIn()
                
            }
        }
    }
    //MARK: - Actions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        do {
            try signIn()
        }catch SignUpError.isValidEmail{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Email")
        }catch SignUpError.isValidPassword{
            showNormalAlert(title: "Sorry", message: "Please Enter Valid Password")
        }catch{
            showNormalAlert(title: "Sorry", message: "Please Fill All fields")
        }
    }
    @IBAction func newAccountBtnTapped(_ sender: UIButton) {
        self.goToRegisterScreen()
    }
}


