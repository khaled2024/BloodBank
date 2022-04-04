//
//  AppBloodRequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 01/04/2022.
//

import UIKit
import BLTNBoard

class AppBloodRequestViewController: UIViewController{
    
    @IBOutlet weak var bloodRequestLbl: UILabel!
    @IBOutlet weak var secondTitleLbl: UILabel!
    //request
    @IBOutlet weak var requestTypeLbl: UILabel!
    @IBOutlet weak var requestNext: UIButton!
    //blood type
    @IBOutlet weak var bloodTitleLbl: UILabel!
    @IBOutlet weak var bloodNextBtn: UIButton!
    @IBOutlet weak var bloodBackBtn: UIButton!
    //reason
    @IBOutlet weak var reasonTitleLbl: UILabel!
    @IBOutlet weak var reasonNextBtn: UIButton!
    @IBOutlet weak var reasonBackBtn: UIButton!
    //hospital
    @IBOutlet weak var hospitalTitleLbl: UILabel!
    @IBOutlet weak var hospitalNextBtn: UIButton!
    @IBOutlet weak var hospitalBackBtn: UIButton!
    //notes
    @IBOutlet weak var notesTitleLbl: UILabel!
    @IBOutlet weak var notesFinishBtn: UIButton!
    @IBOutlet weak var notesBackBtn: UIButton!
    
    // views& pickerViews
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var requestTypeView: UIView!
    @IBOutlet weak var requestTypePickerView: UIPickerView!
    @IBOutlet weak var bloodTypeView: UIView!
    @IBOutlet weak var bloodTypePickerView: UIPickerView!
    @IBOutlet weak var reasonRequestView: UIView!
    @IBOutlet weak var reasonPickerView: UIPickerView!
    @IBOutlet weak var hospitalRequestView: UIView!
    @IBOutlet weak var hospitalPickerView: UIPickerView!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    //MARK: - vars
    var requestTypeResult = ""
    var bloodTypeResult = ""
    var reasonRequestResult = ""
    var hospitalResult = ""
    let arrTypeRequest = Arrays.arrayOfTypesRequests
    let arrBloodType = Arrays.arrayOfBloodType
    let arrReason = Arrays.arrayReasonRequest
    let arrHospitals = Arrays.arrayOfHospitals
    let navBar = NavigationBar()
    let customView = CustomView()
    private lazy var fitBoardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Congratulation")
        item.image = UIImage(named: "launch")
        item.actionButtonTitle = "OK"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string:"Your Blood Request Created Successfully" , attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true) {
//                self.navigationController?.popToRootViewController(animated: true)
                let requestsVC = RequestViewController.instantiate()
                self.navigationController?.pushViewController(requestsVC, animated: true)
                self.modalTransitionStyle = .coverVertical
                self.modalPresentationStyle = .fullScreen
            }
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTypePickerView.delegate = self
        requestTypePickerView.dataSource = self
        bloodTypePickerView.delegate = self
        bloodTypePickerView.dataSource = self
        reasonPickerView.delegate = self
        reasonPickerView.dataSource = self
        hospitalPickerView.delegate = self
        hospitalPickerView.dataSource = self
        
        requestTypePickerView.selectRow(2, inComponent: 0, animated: true)
        bloodTypePickerView.selectRow(2, inComponent: 0, animated: true)
        reasonPickerView.selectRow(2, inComponent: 0, animated: true)
        hospitalPickerView.selectRow(2, inComponent: 0, animated: true)
        
        
        requestTypeView.isHidden = false
        bloodTypeView.isHidden = true
        reasonRequestView.isHidden = true
        hospitalRequestView.isHidden = true
        notesView.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpDesign()
        self.localizedItems()
    }
    //MARK: - private functions
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "انشاء طلب دم", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        self.navigationController?.navigationBar.isHidden = false
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem// This will show in the next view controller being pushed
    }
    
    private func localizedItems(){
        bloodRequestLbl.customLblFont(lbl: bloodRequestLbl, fontSize: 25, text: "First Title")
        secondTitleLbl.customLblFont(lbl: secondTitleLbl, fontSize: 19, text: "Second Title")
        requestTypeLbl.customLblFont(lbl: requestTypeLbl, fontSize: 19, text: "Request Type")
        bloodTitleLbl.customLblFont(lbl: bloodTitleLbl, fontSize: 19, text: "Blood Type")
        reasonTitleLbl.customLblFont(lbl: reasonTitleLbl, fontSize: 19, text: "Reason of the Request")
        hospitalTitleLbl.customLblFont(lbl: hospitalTitleLbl, fontSize: 19, text: "Hospital Title")
        notesTitleLbl.customLblFont(lbl: notesTitleLbl, fontSize: 19, text: "Notes Title")
        
        requestNext.customTitleLbl(btn: requestNext, text: "Next", fontSize: 18)
        bloodNextBtn.customTitleLbl(btn: bloodNextBtn, text: "Next", fontSize: 18)
        reasonNextBtn.customTitleLbl(btn: reasonNextBtn, text: "Next", fontSize: 18)
        hospitalNextBtn.customTitleLbl(btn: hospitalNextBtn, text: "Next", fontSize: 18)
        notesFinishBtn.customTitleLbl(btn: notesFinishBtn, text: "Finish", fontSize: 18)
        bloodBackBtn.customTitleLbl(btn: bloodBackBtn, text: "Back", fontSize: 18)
        reasonBackBtn.customTitleLbl(btn: reasonBackBtn, text: "Back", fontSize: 18)
        hospitalBackBtn.customTitleLbl(btn: hospitalBackBtn, text: "Back", fontSize: 18)
        notesBackBtn.customTitleLbl(btn: notesBackBtn, text: "Back", fontSize: 18)
        customView.requestView(theView: requestTypeView)
        customView.requestView(theView: bloodTypeView)
        customView.requestView(theView: reasonRequestView)
        customView.requestView(theView: hospitalRequestView)
        customView.requestView(theView: notesView)
    }
    func animate(theview: UIView){
        UIView.transition(with: theview, duration: 1, options: [.transitionCurlUp], animations: {
            theview.alpha = 0.0
        }, completion: {_ in
            theview.isHidden = true
        })
    }
    
    //MARK: - Actions
    @IBAction func requestTypenextBtn(_ sender: UIButton) {
        animate(theview: requestTypeView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.bloodTypeView.isHidden = false
            self.bloodTypeView.alpha = 1
        }
    }
    
    //blood type
    @IBAction func nextbloodTypeBtnTapped(_ sender: UIButton) {
        animate(theview: bloodTypeView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.reasonRequestView.isHidden = false
            self.reasonRequestView.alpha = 1
        }
    }
    @IBAction func backBloodType(_ sender: UIButton) {
        self.animate(theview: self.bloodTypeView)
        self.requestTypeView.isHidden = false
        requestTypeView.alpha = 1
    }
    
    //reason
    @IBAction func reasonNextTapped(_ sender: UIButton) {
        animate(theview: reasonRequestView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.hospitalRequestView.isHidden = false
            self.hospitalRequestView.alpha = 1
        }
    }
    
    @IBAction func reasonBackTapped(_ sender: UIButton) {
        animate(theview: reasonRequestView)
        bloodTypeView.isHidden = false
        requestTypeView.isHidden = true
        self.bloodTypeView.alpha = 1
    }
    
    // hospital
    
    @IBAction func hospitalNext(_ sender: UIButton) {
        animate(theview: hospitalRequestView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.75) {
            self.notesView.isHidden = false
            self.notesView.alpha = 1
            
        }
    }
    @IBAction func hospitalBackTapped(_ sender: UIButton) {
        animate(theview: hospitalRequestView)
        reasonRequestView.isHidden = false
        bloodTypeView.isHidden = true
        requestTypeView.isHidden = true
        self.reasonRequestView.alpha = 1
    }
    //notes
    @IBAction func finishNotesTapped(_ sender: UIButton) {
        if let noteResult = notesTextView.text , !noteResult.isEmpty{
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                print("\(self.requestTypeResult) - \(self.bloodTypeResult) - \(self.reasonRequestResult) - \(self.hospitalResult) - \(noteResult)")
            }
            self.fitBoardManager.showBulletin(above: self)
        }else{
            showAlert(title: "Sorry", message: "Please Write A message For Donors.")
        }
    }
    
    @IBAction func notesBackTapped(_ sender: UIButton) {
        animate(theview: notesView)
        reasonRequestView.isHidden = true
        bloodTypeView.isHidden = true
        requestTypeView.isHidden = true
        hospitalRequestView.isHidden = false
        self.hospitalRequestView.alpha = 1
    }
}
//MARK: - UIPickerViewDelegate
extension AppBloodRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag{
        case 0:
            return arrTypeRequest.count
        case 1:
            return arrBloodType.count
        case 2:
            return arrReason.count
        case 3:
            return arrHospitals.count
        default:
            return 1
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 0:
            self.requestTypeResult = arrTypeRequest[row]
            return arrTypeRequest[row]
        case 1:
            self.bloodTypeResult = arrBloodType[row]
            return arrBloodType[row]
        case 2:
            self.reasonRequestResult = arrReason[row]
            return arrReason[row]
        case 3:
            self.hospitalResult = arrHospitals[row]
            return arrHospitals[row]
        default:
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
}
