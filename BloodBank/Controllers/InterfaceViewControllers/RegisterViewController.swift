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
    private let GovPicker = UIPickerView()
    private let CityPicker = UIPickerView()
    private let GenderPicker = UIPickerView()
    private var arrayOfBloodType = Arrays.arrayOfBloodType
    var customBtn = UserCustomBtn()
    var customTF = UserCustomTF()
    let customView = CustomView()
    var gradientBackground = UserGradientBackground()
    let datePickerView = UIDatePicker()
    let navBar = NavigationBar()
    
    var dicOfGov :[String:String] = [:]
    var arrOfGov: [GovData] = [GovData]()
    var CitiesArr: [DataCities] = [DataCities]()
    var dicOfCity :[String:String] = [:]
    var arrOfCity: [CityData] = [CityData]()
    var arrOfBlood: [BloodData] = [BloodData]()
    var dicOfBloodType: [String:String] = [:]
    
    var newCity = userCity( name: "", governoratedId: "")
    var newGov = userGovernorate(id: "", name: "", cities: [])
    var finalCities: [String] = []
    private var arrayOfgover: [userGovernorate] = []
    private var arrayOfcity: [userCity] = []
    var myDicOfCity :[String:String] = [:]
    var rowOfCity: String = ""
    var rowofGov: String = ""
    var rowofBlood: String = ""
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPicker()
        self.firstView.isHidden = false
        self.secondView.isHidden = true
        setUpDatePicker()
        setCityData()
        setGovData()
        getBlood()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
        setNavBar()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    //MARK: - Private functions
    //getting data
    
    private func getBlood(){
        ApiService.sharedService.getBloodType { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                self.arrOfBlood = blood
                for blood in self.arrOfBlood {
                    self.dicOfBloodType[blood.name] = blood.id
                }
                print(self.arrOfBlood)
            }
        }
    }
    private func setGovData(){
        ApiService.sharedService.getGovData { error, gov in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                } else if let gov = gov {
                    self.arrOfGov = gov
                    for gov in self.arrOfGov {
                        self.dicOfGov[gov.id] = gov.name
                    }
                }
            }
        }
    }
    private func getCitiesWithId(id: String){
        ApiService.sharedService.getCitiesById(id: rowofGov) { error, city in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                }else if let city = city {
                    print(city)
                    self.CitiesArr = city
                    self.finalCities = []
                    for cities in self.CitiesArr {
                        print(cities.name)
                        self.finalCities.append(cities.name)
                    }
                    print(self.finalCities)
                }
            }
        }
    }
    private func setCityData(){
        ApiService.sharedService.getCityData { error, city in
            DispatchQueue.main.async {
                if let error = error{
                    print(error)
                } else if let city = city {
                    self.arrOfCity = city
                    for city in self.arrOfCity {
                        self.dicOfCity[city.gov_id] = city.name
                        self.myDicOfCity[city.name] = city.id
                    }
                    print(self.arrOfCity)
                    
                }
                self.rowOfCity = self.myDicOfCity[self.cityTextField.text!] ?? ""
                print("\(self.rowOfCity)")
            }
        }
    }
    private func addUserData(){
        let sha1Pasword =  (passwordTextField.text?.sha1())!
        ApiService.sharedService.addUserData(email: emailTextField.text!, fName: nameTextField.text!,lName: familyNameTextField.text!, id: IDTextField.text!, password: sha1Pasword,fPhone: fNumberTextField.text!,sPhone: sNumberTextField.text!,bloodType:self.rowofBlood,governrate: self.rowofGov,city: self.rowOfCity,birthDay: birthDayTextField.text!, gender: Arrays.dicOfGender[genderTextField.text!]!)
        print("password: \(sha1Pasword)")
    }
   
    //design
    private func setNavBar(){
        navigationController?.navigationBar.barTintColor = UIColor(named: "viewbgColor")
        navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white ,.font: UIFont(name: "Almarai-Bold", size: 18)!]
        navBar.setNavBar(myView: self, title: "انشاء حساب جديد", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }
    private func setUpPicker(){
        BloodTypePicker.tag = 1
        GovPicker.tag = 2
        CityPicker.tag = 3
        GenderPicker.tag = 4
        BloodTypePicker.delegate = self
        BloodTypePicker.dataSource = self
        bloodTypeTextField.inputView = BloodTypePicker
        GovPicker.delegate = self
        GovPicker.dataSource = self
        governmentTextField.inputView = GovPicker
        CityPicker.delegate = self
        CityPicker.dataSource = self
        cityTextField.inputView = CityPicker
        GenderPicker.delegate = self
        GenderPicker.dataSource = self
        genderTextField.inputView = GenderPicker
    }
    private func setUpDesign(){
        self.goToSecondViewBtn.customTitleLbl(btn: goToSecondViewBtn, text: "استمرار", fontSize: 16)
        customBtn.confirmBtnSelected(Btn: goToSecondViewBtn)
        customBtn.confirmBtnSelected(Btn: confirmBtn)
        customView.signUpView(theView: self.firstView)
        customView.signUpView(theView: self.secondView)
    }
    //date picker
    private func setUpDatePicker(){
        datePickerView.datePickerMode = .date
        birthDayTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en")
        birthDayTextField.text = dateFormatter.string(from: sender.date)
        print(dateFormatter.string(from: sender.date))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    private func checkPassword()->Bool{
        if let password = passwordTextField.text , !password.isEmpty , let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    private func checkTextFields()-> Bool{
        if let email = emailTextField.text , !email.isEmpty , let name = nameTextField.text , !name.isEmpty,let familyName = familyNameTextField.text , !familyName.isEmpty , let ID = IDTextField.text , !ID.isEmpty , let fPhone = fNumberTextField.text , !fPhone.isEmpty, let sPhone = sNumberTextField.text, !sPhone.isEmpty , let bloodType = bloodTypeTextField.text , !bloodType.isEmpty, let password = passwordTextField.text ,!password.isEmpty, checkPassword(), let confirmPassword = confirmPasswordTextField.text , !confirmPassword.isEmpty , let gov = governmentTextField.text , !gov.isEmpty, let city = cityTextField.text , !city.isEmpty, let birthDay = birthDayTextField.text , !birthDay.isEmpty , let gender = genderTextField.text , !gender.isEmpty{
            return true
        }else{
            return false
        }
    }
    private func checkValidationTextField() throws {
        if let email = emailTextField.text , let firstName = nameTextField.text ,let familyName = familyNameTextField.text , let ID = IDTextField.text ,  let fPhone = fNumberTextField.text , let sPhone = sNumberTextField.text,  let bloodType = bloodTypeTextField.text ,let password = passwordTextField.text ,  let confirmPassword = confirmPasswordTextField.text , let gov = governmentTextField.text , let city = cityTextField.text, let birthDay = birthDayTextField.text ,  let gender = genderTextField.text {
            if !email.isValidEmail{
                throw SignUpError.isValidEmail
            }
            if !firstName.isValidName{
                throw SignUpError.isValidName
            }
            if !familyName.isValidName{
                throw SignUpError.isValidName
            }
            if !ID.isValidID{
                throw SignUpError.isValidID
            }
            if !password.isValidPassword{
                throw SignUpError.isValidPassword
            }
            if !confirmPassword.isValidPassword{
                throw SignUpError.isValidPassword
            }
            if password != confirmPassword {
                showNormalAlert(title: "Sorry", message: "please check the password")
            }
            if !fPhone.isValidMobile{
                throw SignUpError.isValidMobile
            }
            if !sPhone.isValidMobile{
                throw SignUpError.isValidMobile
            }
            if gov.isEmpty{
                showNormalAlert(title: "Sorry", message: "please check your Governrate")
            }
            if city.isEmpty{
                showNormalAlert(title: "Sorry", message: "please check the Address")
            }
            if bloodType.isEmpty{
                showNormalAlert(title: "Sorry", message: "please check the Blood type")
            }
            if birthDay.isEmpty{
                showNormalAlert(title: "Sorry", message: "please check your Birth Date")
            }
            if gender.isEmpty{
                showNormalAlert(title: "Sorry", message: "please check your Gender")
            }
            if !checkTextFields(){
                showNormalAlert(title: "", message: "Please Fill All fields")
            }else{
                self.animateButtons()
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    self.SuccessAlert(title: "Congratulation", message: "Your Account Created Succesfully", style: .default) { _ in
                        self.addUserData()
                        self.animateButtons()
                        self.goToLoginScreen()
                    }
                }
            }
        }
    }
    private func checkAllFields(){
        if checkPassword(){
            self.animateButtons()
            customBtn.toggleForBtn(Btn: self.confirmBtn)
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                self.SuccessAlert(title: "Congratulation", message: "Your Account Created Succesfully", style: .default) { _ in
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
        self.animateButtons()
        animate(theview: firstView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.secondView.isHidden = false
            self.secondView.alpha = 1
        }
    }
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        self.animateButtons()
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
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        switch pickerView.tag{
        case 1:
            return dicOfBloodType.count
        case 2:
            return dicOfGov.count
        case 3:
            return finalCities.count
        case 4:
            return Arrays.arrOfGender.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag{
        case 1:
            bloodTypeTextField.text = arrOfBlood[row].name
            self.rowofBlood = arrOfBlood[row].id
            print(self.rowofBlood)
        case 2:
            governmentTextField.text = arrOfGov[row].name
            self.rowofGov = arrOfGov[row].id
            print(self.rowofGov)
            self.getCitiesWithId(id: rowofGov)
        case 3:
            cityTextField.text = self.finalCities[row]
            self.rowOfCity = myDicOfCity[self.cityTextField.text!]!
            print("city id in picker view : \(self.rowOfCity)")
        case 4:
            genderTextField.text = Arrays.arrOfGender[row]
        default:
            return
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 1:
            return arrOfBlood[row].name
        case 2:
            return  arrOfGov[row].name
        case 3:
            return self.finalCities[row]
            
        case 4:
            return Arrays.arrOfGender[row]
        default:
            return ""
        }
    }
}
