//
//  HamburgerViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 30/01/2022.
//

import UIKit
protocol HambburgerViewControllerDelegate{
    func hideHamburgerMenu()
}
protocol opacityDelegate {
    func backViewForHumburgerObacity()
}

class HamburgerViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet var mainHumbergerView: UIView!
    @IBOutlet weak var humburgerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appointmentBtn: UIButton!
    
    @IBOutlet weak var availableToDonate: UILabel!
    @IBOutlet weak var coronaBtn: UIButton!
    @IBOutlet weak var donationRequestsBtn: UIButton!
    @IBOutlet weak var previousDonationsBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var yourStory: UIButton!
    @IBOutlet weak var privcyBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var donateSwitch: UISwitch!
    var delegate: HambburgerViewControllerDelegate?
    var delegate2: opacityDelegate?
    let btnCustom = UserCustomBtn()
    let def = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHumburger()
        setUpSwitch()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpLocalizationLabel()
        mainHumbergerView.semanticContentAttribute = .forceLeftToRight
    }
    //MARK: - private functions
    private func setUpSwitch(){
        if let donateSwitch = def.value(forKey: "switch"){
            self.donateSwitch.isOn = donateSwitch as! Bool
        }
    }
    private func setUpLocalizationLabel(){
        let currentLang = Locale.current.languageCode
        if currentLang == "en"{
            availableToDonate.text = "Available to donate".Localized()
            self.btnCustom.setUpBtnFont(btn: appointmentBtn, text: "appointment".Localized())
            self.btnCustom.setUpBtnFont(btn: previousDonationsBtn, text: "Donation History".Localized())
            self.btnCustom.setUpBtnFont(btn: coronaBtn, text: "Corona stats".Localized())
            self.btnCustom.setUpBtnFont(btn: settingBtn, text: "Setting".Localized())
            self.btnCustom.setUpBtnFont(btn: donationRequestsBtn, text: "Donation Requests".Localized())
            self.btnCustom.setUpBtnFont(btn: privcyBtn, text: "Privacy policy".Localized())
            self.btnCustom.setUpBtnFont(btn: logoutBtn, text: "Log out".Localized())
            self.btnCustom.setUpBtnFont(btn: helpBtn, text: "Help & Support".Localized())
            self.btnCustom.setUpBtnFont(btn: yourStory, text: "Your Story".Localized())
        }else{
            // set the default of Btn Font (Almarai)
        }
    }
    private func setUpHumburger(){
        self.humburgerView.layer.cornerRadius = 20
        self.humburgerView.clipsToBounds = true

        self.imageView.layer.borderWidth = 1.0
        self.imageView.layer.masksToBounds = false
        self.imageView.layer.borderColor = CGColor(red:100, green:100, blue: 100, alpha: 1)
        self.imageView.layer.cornerRadius = imageView.frame.size.height/2
        self.imageView.contentMode = .scaleToFill
        self.imageView.clipsToBounds = true

    }
    private func dismissHamburgerMenu(){
        self.delegate?.hideHamburgerMenu()
        self.delegate2?.backViewForHumburgerObacity()
    }
//    MARK: - Actions

    @IBAction func appointmentBtnTapped(_ sender: UIButton) {
        let appointmentVC = AppointmentViewController.instantiate()
        navigationController?.pushViewController(appointmentVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func requestBtnTapped(_ sender: UIButton) {
        let requestVC = RequestViewController.instantiate()
        navigationController?.pushViewController(requestVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()

    }
    @IBAction func donationHistory(_ sender: UIButton) {
        let donationVC = DonationHistoryViewController.instantiate()
        navigationController?.pushViewController(donationVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func coronaStatsBtnTapped(_ sender: UIButton) {
        let coronaStatsVC = CoronaStatsViewController.instantiate()
        self.navigationController?.pushViewController(coronaStatsVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func helpAndSupportBtnTapped(_ sender: UIButton) {
        let helpVC = HelpAndSupportViewController.instantiate()
        navigationController?.pushViewController(helpVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func privacyBtnTapped(_ sender: UIButton) {
        let privacyVC = PrivacyViewController.instantiate()
        navigationController?.pushViewController(privacyVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func settingBtnTapped(_ sender: UIButton) {
        let settingVC = SettingViewController.instantiate()
        navigationController?.pushViewController(settingVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        let homeNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNC")
        self.present(homeNC, animated: true, completion: nil)
        self.modalPresentationStyle = .fullScreen
        
//        let storyboard = UIStoryboard(name: "StartingSB", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC")as! UINavigationController
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .flipHorizontal
//        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func yourStoryBtnTapped(_ sender: UIButton) {
        let yourStoryVC = YourStoryViewController.instantiate()
        navigationController?.pushViewController(yourStoryVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
        
    }
    
    
    
    @IBAction func donateSwichTapped(_ sender: UISwitch) {
        def.set(sender.isOn, forKey: "switch")
    }
}
