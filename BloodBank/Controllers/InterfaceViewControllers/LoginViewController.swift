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
    
    //MARK: - Variables
    var gradientBackground = UserGradientBackground()
    var customTF = UserCustomTF()
    var customBtn = UserCustomBtn()
    let navigationManager = NavigationManager()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customBtn.confirmBtnNotSelected(Btn: loginBtn)
        setNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
    }
    //MARK: -  private functions
    func setNavBar(){
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,.font: UIFont(name: "Almarai", size: 18)!]
    }
    private func setUpDesign(){
        customTF.setUpTextField(textField: emailTextField, nameTextField: "ادخل البريد الاكتروني")
        customTF.setUpTextField(textField: passwordTextField, nameTextField: "ادخل كلمه المرور")
        gradientBackground.setGradientBackground(colorTop: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1), view: view)
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
    //MARK: - Actions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        print("Login succesully")
        if checkTextFields(){
            customBtn.toggleForBtn(Btn: self.loginBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.goToMainScreen()
            }
        }else{
            self.showAlert(title: "Sorry", message: "Please fill the all fields")
        }
    }
    @IBAction func newAccountBtnTapped(_ sender: UIButton) {
        self.goToRegisterScreen()
    }
}


