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
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var bloodBankNameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var noteForHelpTF: UITextField!
    @IBOutlet weak var patientNameTF: UITextField!
    @IBOutlet weak var patientAgeTF: UITextField!
    @IBOutlet weak var createRequestBtn: UIButton!
    
    var bloodType: String = ""
    var bloodBankName: String = ""
    var time: String = ""
 
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setUpDesign()
        setUp()
    }
    //MARK: - Private functions
    private func setUp(){
        self.bloodTypeLbl.text = "فصيله \(bloodType)"
        self.bloodBankNameLbl.text = bloodBankName
        self.timeLbl.text = time
      
        print(bloodBankNameLbl.text!)

    }
    
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))
        gradient.setGradientBackground(colorTop: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), colorBottom: #colorLiteral(red: 0.895557344, green: 0.1643874943, blue: 0.328651458, alpha: 1), view: gradientView)
        
    }
    //MARK: - Actions
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    @IBAction func createRequestBtnTapped(_ sender: UIButton) {
        print("bloodType is \(bloodTypeLbl.text!) ,bloodBankName is \(bloodBankNameLbl!) , time is \(timeLbl.text!) , paitent name is \(patientNameTF.text!) , patient age is \(patientAgeTF.text!), note is \(noteForHelpTF.text!)")
    }
}
//MARK: - Exteision


