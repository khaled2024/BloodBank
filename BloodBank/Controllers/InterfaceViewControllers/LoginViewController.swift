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
    }
    override func viewWillAppear(_ animated: Bool) {
       setUpDesign()
    }
    //MARK: -  functions
    private func setUpDesign(){
        customTF.setUpTextField(textField: emailTextField, nameTextField: "Enter Your Email")
        customTF.setUpTextField(textField: passwordTextField, nameTextField: "Enter Your Password")
        gradientBackground.setGradientBackground(colorTop: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), colorBottom: #colorLiteral(red: 1, green: 0.5385724902, blue: 0.5328875184, alpha: 1), view: view)
    }
    private func goToMainScreen(){
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.7, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        
    }
    
    //MARK: - Actions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        print("Login succesully")
        customBtn.toggleForBtn(Btn: loginBtn)
        
//        goToMainScreen()
    }
    
}
