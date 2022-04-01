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
    @IBOutlet weak var familyNameTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    //MARK: - variables
    private let BloodTypePicker = UIPickerView()
    private var arrayOfBloodType = Arrays.arrayOfBloodType
    var customBtn = UserCustomBtn()
    var customTF = UserCustomTF()
    var gradientBackground = UserGradientBackground()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPicker()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
        setNavBar()
    }
    
    //MARK: - Private functions
    private func setNavBar(){
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.918268621, green: 0.2490310073, blue: 0.3684441447, alpha: 1),.font: UIFont(name: "Almarai-Bold", size: 25)!]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8666378856, green: 0.2537421584, blue: 0.3427102566, alpha: 1)
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white ,.font: UIFont(name: "Almarai-Bold", size: 18)!]
    }
    private func setUpPicker(){
        BloodTypePicker.tag = 1
        BloodTypePicker.delegate = self
        BloodTypePicker.dataSource = self
        bloodTypeTextField.inputView = BloodTypePicker
        
    }
    
    private func setUpDesign(){
        
        //        customBtn.confirmBtnNotSelected(Btn: ConfirmBtn)
        customBtn.confirmBtnSelected(Btn: ConfirmBtn)
    }
    private func checkPassword()->Bool{
        if let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    private func checkTextFields()-> Bool{
        if let email = emailTextField.text , !email.isEmpty , let name = nameTextField.text , !name.isEmpty,let familyName = familyNameTextField.text , !familyName.isEmpty , let ID = IDTextField.text , !ID.isEmpty , let phone = phoneTextField.text , !phone.isEmpty , let bloodType = bloodTypeTextField.text , !bloodType.isEmpty, let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , let address = addressTextField.text , !address.isEmpty   {
            return true
        }else{
            return false
        }
    }
    private func checkAllFields(){
        if checkPassword() && checkPassword(){
            self.animateButtons()
            customBtn.toggleForBtn(Btn: self.ConfirmBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.SuccessAlert(title: "Congratulation", message: "Your Account Created Succesfully", style: .default) { _ in
                    self.animateButtons()
                    self.goToLoginScreen()
                }
            }
        }else{
            self.showAlert(title: "Sorry", message: "Please Check your password")
        }
    }
    private func goToLoginScreen(){
        let loginScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")as! LoginViewController
        navigationController?.pushViewController(loginScreen, animated: true)
    }
    private func animateButtons(){
        UIView.animate(withDuration: 0.5) {
            self.ConfirmBtn.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.5) {
                    self.ConfirmBtn.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
    }
    //MARK: - Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
       checkAllFields()
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
