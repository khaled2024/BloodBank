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
    let navBar = NavigationBar()
    let gradient = UserGradientBackground()
    let customBtn = UserCustomBtn()
    
    
    
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
    var isEdited = false
    //MARK: - lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.layer.cornerRadius = imageView.frame.size.height/2
        setUpDesign()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            super.viewDidLayoutSubviews()
            gradientView.roundedCornerView(corners: [.bottomLeft , .bottomRight], radius: gradientView.frame.size.width/6)
    }
    
    //MARK: - private func
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
           
        }else{
            isEdited = false
            self.editBtn.image = UIImage(systemName: "square.and.pencil")
            self.makeTFInteract(result: false)
            self.theNameLbl.text = "\(self.donorNameTF.text!) \(self.familyNameTF.text!)"
            self.addressLbl.text = "\(self.gavernrateTF.text!)/\(self.cityTF.text!)"
            
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
