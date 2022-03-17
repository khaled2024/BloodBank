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
    let navBar = NavigationBar()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        customBtn.confirmBtnNotSelected(Btn: loginBtn)
        customBtn.confirmBtnSelected(Btn: loginBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
    }
    //MARK: -  private functions
    private func setUpDesign(){
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        
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
        if checkTextFields(){
            customBtn.toggleForBtn(Btn: self.loginBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                self.goToMainScreen()
                print("Login succesully")
            }
        }else{
            self.showAlert(title: "Sorry", message: "Please fill the all fields")
        }
    }
    @IBAction func newAccountBtnTapped(_ sender: UIButton) {
        self.goToRegisterScreen()
    }
}


