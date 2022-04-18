//
//  SecondRequestBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 14/03/2022.
//

import UIKit

class SecondRequestBloodViewController: UIViewController {
    //MARK: - Outlets
    let navBar = NavigationBar()
    let gradient = UserGradientBackground()
    var sick: Sick?
    var patient: Patient? = nil
    
    @IBOutlet weak var bloodQuantityLbl: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var bloodBankNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var noteForHelpTF: UITextField!
    @IBOutlet weak var patientNameTF: UITextField!
    @IBOutlet weak var patientAgeTF: UITextField!
    @IBOutlet weak var createRequestBtn: UIButton!
    
    var customBtn = UserCustomBtn()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setUpDesign()
    }
   
    //MARK: - Private functions
    private func setUp(){
        self.bloodTypeLbl.text = "فصيله \(sick?.bloodType ?? "")"
        self.bloodBankNameLbl.text = sick?.address
        self.timeLbl.text = sick?.time
        self.bloodQuantityLbl.text = sick?.quantity
    }
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))
        gradient.setGradientBackground(colorTop: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), colorBottom: #colorLiteral(red: 0.895557344, green: 0.1643874943, blue: 0.328651458, alpha: 1), view: gradientView)
//        gradientView.backgroundColor = #colorLiteral(red: 0.918268621, green: 0.2490310073, blue: 0.3684441447, alpha: 1)
        self.customBtn.confirmBtnNotSelected(Btn: createRequestBtn)
        
    }
    private func checkDataRequest()-> Bool{
        if let patientName = patientNameTF.text , !patientName.isEmpty , let age = patientAgeTF.text , !age.isEmpty , let note = noteForHelpTF.text , !note.isEmpty {
            return true
        }
        return false
    }
    private func createBloodRquest(){
        patient = Patient(name: patientNameTF.text!, bloodType: self.bloodTypeLbl.text!, address: self.bloodBankNameLbl.text!, time: self.timeLbl.text!, description: noteForHelpTF.text!, donorImage: "https://i.pinimg.com/originals/0c/5f/12/0c5f12f37fb6bc00f4d468b5d69e9932.jpg")
        NotificationCenter.default.post(name: Notification.Name(Notifications.detailNot), object: patient)
        print("GetPosted")

        print("bloodType is \(bloodTypeLbl.text!),blood quantity is equal \(bloodQuantityLbl.text!) ,bloodBankName is \(bloodBankNameLbl!) , time is \(timeLbl.text!) , paitent name is \(patientNameTF.text!) , patient age is \(patientAgeTF.text!), note is \(noteForHelpTF.text!)")
        self.SuccessAlert(title: "Congratulation", message: "The BloodRequest has been Created Successfuly", style: .default) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func createRequestBtnTapped(_ sender: UIButton) {
        if self.checkDataRequest(){
            self.createBloodRquest()
            self.customBtn.toggleForBtn(Btn: createRequestBtn)
            createRequestBtn.backgroundColor = #colorLiteral(red: 1, green: 0.2901960784, blue: 0.3843137255, alpha: 1)
        }else{
            self.showNormalAlert(title: "Sorry", message: "Please fill the Fields.")
        }
        
    }
}
//MARK: - Exteision
