//
//  DonateBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit
import BLTNBoard
class DonateBloodViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var scaduleBtn: UIButton!
    @IBOutlet weak var moneyDonationBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var nextViewAppointment: UIButton!
    @IBOutlet weak var yesGoodHealth: UIButton!
    @IBOutlet weak var noGoodHealth: UIButton!
    @IBOutlet weak var yesKiloGram: UIButton!
    @IBOutlet weak var noKiloGram: UIButton!
    @IBOutlet weak var noDays: UIButton!
    @IBOutlet weak var yesDays: UIButton!
    @IBOutlet weak var yesTattoo: UIButton!
    @IBOutlet weak var noTattoo: UIButton!
    
    
    @IBOutlet weak var btnNextForSchedlling: UIButton!
    @IBOutlet weak var btnNextForMoney: UIButton!
    @IBOutlet weak var btnBackForSchedulling: UIButton!
    @IBOutlet weak var btnBackForMoney: UIButton!
    //MARK: - Variables
    let customBtn = UserCustomBtn()
    let navBar = NavigationBar()
    let navigationManager = NavigationManager()
    
    private lazy var notFitBoardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "")
        item.image = UIImage(named: "NotFitness")
        item.actionButtonTitle = "حسناً"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string: "كن قويا وحاول مره اخري بعد فتره،ناسف لعدم تمكنك من التبرع بالدم.", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.navigationManager.show(screen: .tapBarController, inController: self)
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    private lazy var fitBoardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "")
        item.image = UIImage(named: "fitman2")
        item.actionButtonTitle = "حسناً"
        item.actionButton?.titleLabel?.font = UIFont(name: "Almarai", size: 20)
        item.attributedDescriptionText = NSAttributedString(
            string: "احسنت لقد نجحت في الاختبار،كن بطلاً في حياه شخص ما.", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!])
        item.actionHandler = {_ in
            self.dismiss(animated: true) {
                self.scaduleBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
                self.moneyDonationBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
            }
        }
        item.appearance.actionButtonColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        item.appearance.actionButtonCornerRadius = 15
        return BLTNItemManager(rootItem: item)
    }()
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTags()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpDesign()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.roundedCornerView(corners: [.bottomLeft , .topLeft], radius: myView.frame.size.width/0.2)
    }
    //MARK: - Private Functions
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Donate Blood".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        
        customBtn.customBtn(Btn: scaduleBtn, tintColor: .white, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , bgColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        customBtn.customBtn(Btn: moneyDonationBtn, tintColor: .white, borderColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), bgColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1))
        insideView.semanticContentAttribute = .forceLeftToRight
        self.btnChangesInViewWithLang()
        
    }
    private func btnChangesInViewWithLang(){
        let currentLang = Locale.current.languageCode
        if currentLang == "en"{
            self.btnBackForSchedulling.isHidden = true
            self.btnBackForMoney.isHidden = true
            print("current language:\(currentLang!)")
        }else{
            self.btnNextForSchedlling.isHidden = true
            self.btnNextForMoney.isHidden = true
            self.btnBackForSchedulling.isHidden = false
            self.btnBackForMoney.isHidden = false
        }
    }
    private func buttonTags(){
        self.yesGoodHealth.tag = 1
        self.noGoodHealth.tag = 2
        self.yesKiloGram.tag = 3
        self.noKiloGram.tag = 4
        self.yesDays.tag = 5
        self.noDays.tag = 6
        self.yesTattoo.tag = 7
        self.noTattoo.tag = 8
    }
    private func scaduleScreen(){
        let scadulleScreen = BookingAppointmentViewController.instantiate()
        navigationController?.pushViewController(scadulleScreen, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    private func moneyOrder(){
        let donateMoney = DonateMoneyViewController.instantiate()
        navigationController?.pushViewController(donateMoney, animated: true)
        self.modalTransitionStyle = .partialCurl
    }
    //MARK: - Actions
    @IBAction func scaduleBtnTapped(_ sender: Any) {
        if scaduleBtn.backgroundColor == #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) && moneyDonationBtn.backgroundColor == #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1){
            self.scaduleScreen()
        }else{
            scaduleBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
    @IBAction func moneyDonationBtnTapped(_ sender: UIButton) {
        self.moneyOrder()
    }
    @IBAction func nextViewBtnTapped(_ sender: UIButton) {
        let buttonSender = sender.tag
        if sender == nextViewAppointment{
            self.insideView.transform = CGAffineTransform(translationX: -350, y: 0)
        }else if buttonSender == 1{
            self.insideView.transform = CGAffineTransform(translationX: -750, y: 0)
        }else if buttonSender == 3{
            self.insideView.transform = CGAffineTransform(translationX: -1150, y: 0)
        }else if buttonSender == 6{
            self.insideView.transform = CGAffineTransform(translationX: -1550, y: 0)
        }else if buttonSender == 8{
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.scaduleBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
                self.moneyDonationBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
            }
            self.fitBoardManager.showBulletin(above: self)
        }
    }
    @IBAction func failTest(_ sender: UIButton) {
        let buttonSender = sender.tag
        if buttonSender == 2 || buttonSender == 4 || buttonSender == 5 || buttonSender == 7{
            scaduleBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            moneyDonationBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.notFitBoardManager.showBulletin(above: self)
        }
    }
}
//MARK: - Comments
//import Lottie

// here AnimationView
//        LottieAnimation()
//    private func LottieAnimation(){
//        let animationView = AnimationView(name: "97383-yellow-delivery-guy")
//        animationView.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
//        animationView.center = self.view.center
//        animationView.contentMode = .scaleAspectFit
//        view.addSubview(animationView)
//        animationView.play()
//        animationView.loopMode = .loop
//    }
