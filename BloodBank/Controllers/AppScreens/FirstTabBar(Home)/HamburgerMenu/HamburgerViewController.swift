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
    @IBOutlet weak var subNameLbl: UILabel!
    @IBOutlet weak var donorNameLbl: UILabel!
    @IBOutlet var mainHumbergerView: UIView!
    @IBOutlet weak var humburgerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var appointmentBtn: UIButton!
    
    @IBOutlet weak var coronaBtn: UIButton!
    @IBOutlet weak var donationRequestsBtn: UIButton!
    @IBOutlet weak var volunteersBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var yourStory: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var buyBloodBtn: UIButton!
    
    var delegate: HambburgerViewControllerDelegate?
    var delegate2: opacityDelegate?
    let btnCustom = UserCustomBtn()
    let def = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHumburger()
        if let userName = def.object(forKey: "userInfo")as? [String]{
            self.donorNameLbl.text = "\(userName[1]) \(userName[2])"
        }
        subNameLbl.customLblFont(lbl: subNameLbl, fontSize: 18, text: "Hero")
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpLocalizationLabel()
        mainHumbergerView.semanticContentAttribute = .forceLeftToRight
    }
    //MARK: - private functions
   
    private func setUpLocalizationLabel(){
        let currentLang = Locale.current.languageCode
        if currentLang == "en"{
           
            self.btnCustom.setUpBtnFont(btn: coronaBtn, text: "Corona stats".Localized())
            self.btnCustom.setUpBtnFont(btn: settingBtn, text: "Setting".Localized())
            self.btnCustom.setUpBtnFont(btn: donationRequestsBtn, text: "Donation Requests".Localized())
            self.btnCustom.setUpBtnFont(btn: favoriteBtn, text: "Favorite".Localized())
            self.btnCustom.setUpBtnFont(btn: buyBloodBtn, text: "Buy Blood".Localized())
            self.btnCustom.setUpBtnFont(btn: logoutBtn, text: "Log out".Localized())
            self.btnCustom.setUpBtnFont(btn: volunteersBtn, text: "volunteers".Localized())
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

    
    @IBAction func requestBtnTapped(_ sender: UIButton) {
        let requestVC = RequestViewController.instantiate()
        navigationController?.pushViewController(requestVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()

    }
    @IBAction func volunteersBtnTapped(_ sender: UIButton) {
        let volunteersVC = VolunteersViewController.instantiate()
        navigationController?.pushViewController(volunteersVC, animated: true)
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
    @IBAction func favoriteBtnTapped(_ sender: UIButton) {
        let favoriteVC = FavoriteViewController.instantiate()
        navigationController?.pushViewController(favoriteVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func buyBloodBtnTapped(_ sender: UIButton) {
        let buyBloodVC = BuyBloodViewController.instantiate()
        navigationController?.pushViewController(buyBloodVC, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
}
