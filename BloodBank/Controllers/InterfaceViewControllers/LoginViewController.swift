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
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
//        let storyboard = UIStoryboard(name: "projectMainTabBar", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .flipHorizontal
//        self.present(vc, animated: true, completion: nil)
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


