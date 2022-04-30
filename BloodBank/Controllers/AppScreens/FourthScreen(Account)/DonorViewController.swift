//
//  DonorViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class DonorViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet var gradientView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var theNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var donorNameTF: UITextField!
    @IBOutlet weak var bloodTypeTF: UITextField!
    @IBOutlet weak var firstNumTF: UITextField!
    @IBOutlet weak var secondNumTF: UITextField!
    @IBOutlet weak var familyNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var gavernrateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var birthdateTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    //labels
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var familyNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var governLbl: UILabel!
    @IBOutlet weak var cityLbl:
    UILabel!
    @IBOutlet weak var firstNumLbl: UILabel!
    @IBOutlet weak var secondNumLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    //MARK: - Vars
    let navBar = NavigationBar()
    let gradient = UserGradientBackground()
    let customBtn = UserCustomBtn()
    var isEdited = false
    let goverArr = Arrays.arrayOfGover
    let citiesArr = Arrays.arrayOfCities
    let arrBlood = Arrays.arrayOfBloodType
    let arrGender = Arrays.arrayOfGender
    let datePicker = UIDatePicker()
    var arrOfUser:[userData] = [userData]()
    let def = UserDefaults.standard
    var cityId: String!
    // arrays
    var rowOfCity: String = ""
    var rowofGov: String = ""
    var rowofBlood: String = ""
    var arrOfBlood: [BloodData] = [BloodData]()
    var dicOfBloodType: [String:String] = [:]
    var dicOfGov :[String:String] = [:]
    var finalCities: [String] = []
    var CitiesArr: [DataCities] = [DataCities]()
    var arrOfGov: [GovData] = [GovData]()
    var arrOfCity: [CityData] = [CityData]()
    var dicOfCity :[String:String] = [:]
    static let arrayOfGender = ["male","female"]
    //MARK: - lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setCityData()
        setGovData()
        getBlood()
        serUpPickerViews()
        createDatePicker()
        setDataOfUser()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.layer.cornerRadius = imageView.frame.size.height/2
        setUpDesign()
        localized()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        super.viewDidLayoutSubviews()
        gradientView.roundedCornerView(corners: [.bottomLeft , .bottomRight], radius: gradientView.frame.size.width/6)
    }
    //MARK: - private func
    // get blood data
    private func getBlood(){
        ApiService.sharedService.getBloodType { error, blood in
            if let error = error {
                print(error.localizedDescription)
            }else if let blood = blood {
                self.arrOfBlood = blood
                for blood in self.arrOfBlood {
                    self.dicOfBloodType[blood.id] = blood.name
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
                    }
                    print(self.arrOfCity)
                }
            }
        }
    }
    private func updateUserData(){
        if let user = def.object(forKey: "userInfo")as? [String]{
            if let p_ssn = self.idTF.text,!p_ssn.isEmpty, let f_name = self.donorNameTF.text,!f_name.isEmpty , let l_name = self.familyNameTF.text,!l_name.isEmpty, let email = self.emailTF.text , !email.isEmpty , let mopilePhone = self.firstNumTF.text,!mopilePhone.isEmpty , let secondPhone = secondNumTF.text,!secondPhone.isEmpty , let password = self.passwordTF.text ,!password.isEmpty , let bloodType = self.bloodTypeTF.text , !bloodType.isEmpty , let birthDay = self.birthdateTF.text , !birthDay.isEmpty , let city = self.cityTF.text , !city.isEmpty , let gov = self.gavernrateTF.text , !gov.isEmpty , let password = self.passwordTF.text , !password.isEmpty , let gender = self.genderTF.text , !gender.isEmpty{
                
                ApiService.sharedService.updateUserData(p_ssn: user[0], p_first_name: f_name, p_last_name: l_name ,email: email,gov: gov,city: self.rowOfCity, mopilePhone:mopilePhone,secondPhone:secondPhone,birthDay:birthDay,bloodType:self.rowofBlood,password:password,gender:Arrays.dicOfGender[genderTF.text!]!)
                UserDefaults.standard.set([p_ssn , f_name , l_name, email, gov, city,mopilePhone,secondPhone,birthDay,bloodType ,password, gender,self.cityId], forKey: "userInfo")
            }
            
        }else{
            print("error")
        }
    }
    private func setDataOfUser(){
        let def = UserDefaults.standard
        if let userInfo = def.object(forKey: "userInfo")as? [String]{
            self.idTF.text = userInfo[0]
            self.donorNameTF.text = userInfo[1]
            self.familyNameTF.text = userInfo[2]
            self.emailTF.text = userInfo[3]
            self.gavernrateTF.text = userInfo[4]
            self.cityTF.text = userInfo[5]
            self.firstNumTF.text = userInfo[6]
            self.secondNumTF.text = userInfo[7]
            self.birthdateTF.text = userInfo[8]
            self.bloodTypeTF.text = userInfo[9]
            self.passwordTF.text = userInfo[10]
            self.genderTF.text = userInfo[11]
            self.cityId = userInfo[12]
            print("city id : \(userInfo[12])")
        }
    }
    private func createDatePicker(){
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        birthdateTF.inputView = datePickerView
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthdateTF.text = dateFormatter.string(from: sender.date)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func localized(){
        self.firstNameLbl.customLblFont(lbl: firstNameLbl, fontSize: 19, text: "FistName".Localized())
        self.familyNameLbl.customLblFont(lbl: familyNameLbl, fontSize: 19, text: "FamilyName".Localized())
        self.emailLbl.customLblFont(lbl: emailLbl, fontSize: 19, text: "Email".Localized())
        self.governLbl.customLblFont(lbl: governLbl, fontSize: 19, text: "Governrate".Localized())
        self.cityLbl.customLblFont(lbl: cityLbl, fontSize: 19, text: "City".Localized())
        self.firstNumLbl.customLblFont(lbl: firstNumLbl, fontSize: 19, text: "FistNum".Localized())
        self.secondNumLbl.customLblFont(lbl: secondNumLbl, fontSize: 19, text: "SecondNum".Localized())
        self.idLbl.customLblFont(lbl: idLbl, fontSize: 19, text: "ID".Localized())
        self.passwordLbl.customLblFont(lbl: passwordLbl, fontSize: 19, text: "Password".Localized())
        self.bloodTypeLbl.customLblFont(lbl: bloodTypeLbl, fontSize: 19, text: "BloodType".Localized())
        self.genderLbl.customLblFont(lbl: genderLbl, fontSize: 19, text: "Gender".Localized())
        self.birthDateLbl.customLblFont(lbl: birthDateLbl, fontSize: 19, text: "BirthDate".Localized())
        
    }
    func serUpPickerViews(){
        let goverPickerView = UIPickerView()
        let citiesPickerView = UIPickerView()
        let bloodPickerView = UIPickerView()
        let genderPickerView = UIPickerView()
        gavernrateTF.inputView = goverPickerView
        cityTF.inputView = citiesPickerView
        bloodTypeTF.inputView = bloodPickerView
        genderTF.inputView = genderPickerView
        goverPickerView.tag = 0
        citiesPickerView.tag = 1
        genderPickerView.tag = 2
        bloodPickerView.tag = 3
        goverPickerView.delegate = self
        goverPickerView.dataSource = self
        citiesPickerView.delegate = self
        citiesPickerView.dataSource = self
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        bloodPickerView.delegate = self
        bloodPickerView.dataSource = self
    }
    private func setUpDesign(){
        self.navigationController?.navigationBar.backgroundColor = .clear
        gradient.setGradientBackground(colorTop: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), colorBottom: #colorLiteral(red: 0.895557344, green: 0.1643874943, blue: 0.328651458, alpha: 1), view: gradientView)
        view.semanticContentAttribute = .forceLeftToRight
        
        makeTFInteract(result: false)
        self.theNameLbl.text = "\(self.donorNameTF.text!) \(self.familyNameTF.text!)"
        self.addressLbl.text = "\(self.gavernrateTF.text!)/\(self.cityTF.text!)"
        
        
    }
    private func makeTFInteract(result: Bool){
        self.donorNameTF.isUserInteractionEnabled = result
        self.familyNameTF.isUserInteractionEnabled = result
        self.emailTF.isUserInteractionEnabled = result
        self.gavernrateTF.isUserInteractionEnabled = result
        self.cityTF.isUserInteractionEnabled = result
        self.firstNumTF.isUserInteractionEnabled = result
        self.secondNumTF.isUserInteractionEnabled = result
        self.idTF.isUserInteractionEnabled = result
        self.birthdateTF.isUserInteractionEnabled = result
        self.genderTF.isUserInteractionEnabled = result
        self.bloodTypeTF.isUserInteractionEnabled = result
        self.passwordTF.isUserInteractionEnabled = result
    }
    private func shareContent(){
        let activityController: UIActivityViewController
        let defaultText = "Hello \(theNameLbl.text!),I see you have a \(bloodTypeTF.text!) group and i need you to help me for saving a person Can you..?"
        let image = UIImage(named: "blood-donation")
        activityController = UIActivityViewController(activityItems: [defaultText , image!], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
        
    }
    
    //MARK: - Actions
    
    @IBAction func heartBtnTapped(_ sender: UIButton) {
        customBtn.TintColorForBtn(Btn: heartBtn)
    }
    @IBAction func phoneBtnTapped(_ sender: UIButton) {
        print("phone tapped")
        let url: NSURL = URL(string: "tel://\(firstNumTF.text!)")! as NSURL
        UIApplication.shared.open(url as URL)
    }
    @IBAction func shareBtnTapped(_ sender: UIButton) {
        print("share tapped")
        self.shareContent()
        
    }
    @IBAction func editBtnTapped(_ sender: UIBarButtonItem) {
        if isEdited == false{
            isEdited = true
            self.makeTFInteract(result: true)
            self.editBtn.image = UIImage(systemName: "checkmark")
            self.donorNameTF.becomeFirstResponder()
            self.passwordTF.isSecureTextEntry = false
        }else{
            isEdited = false
            self.editBtn.image = UIImage(systemName: "square.and.pencil")
            self.makeTFInteract(result: false)
            self.theNameLbl.text = "\(self.donorNameTF.text!) \(self.familyNameTF.text!)"
            self.addressLbl.text = "\(self.gavernrateTF.text!)/\(self.cityTF.text!)"
            self.passwordTF.isSecureTextEntry = true
            self.updateUserData()
        }
    }
}
//MARK: - Extension (UIPickerViewDelegate):-
extension DonorViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return goverArr.count
        case 1:
            return finalCities.count
        case 2:
            return Arrays.arrayOfGender.count
        case 3:
            return dicOfBloodType.count
        default:
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            gavernrateTF.text = arrOfGov[row].name
            self.rowofGov = arrOfGov[row].id
            print(self.rowofGov)
            self.getCitiesWithId(id: rowofGov)
        case 1:
            cityTF.text = self.finalCities[row]
            self.rowOfCity = arrOfCity[row].id
            print(self.rowOfCity)
        case 2:
            genderTF.text = Arrays.arrayOfGender[row]
        case 3:
            self.bloodTypeTF.text = arrOfBlood[row].name
            self.rowofBlood = arrOfBlood[row].id
            print(self.rowofBlood)
        default:
            return
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return arrOfGov[row].name
        case 1:
            return finalCities[row]
        case 2:
            return Arrays.arrayOfGender[row]
        case 3:
            return arrOfBlood[row].name
        default:
            return ""
        }
    }
}
//MARK: - comments

//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification), name: Notification.Name (Notifications.detailNot), object: nil)

//navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))

//    @objc func didGetNotification(_ notification: Notification){
//        let patient = notification.object as! Patient
//        self.lbl.text = patient.name
//        view.backgroundColor = .darkGray
//    }


//

