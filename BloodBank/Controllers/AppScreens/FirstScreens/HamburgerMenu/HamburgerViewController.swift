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
    @IBOutlet weak var humburgerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var appointmentBtn: UIButton!
    
    var delegate: HambburgerViewControllerDelegate?
    var delegate2: opacityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHumburger()
    }
    //MARK: - private functions
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
        let appointmentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppointmentViewController")as? AppointmentViewController
        navigationController?.pushViewController(appointmentVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func requestBtnTapped(_ sender: UIButton) {
        let requestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestViewController")as? RequestViewController
        navigationController?.pushViewController(requestVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()

    }
    @IBAction func donationHistory(_ sender: UIButton) {
        let donationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DonationHistoryViewController")as? DonationHistoryViewController
        navigationController?.pushViewController(donationVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func helpAndSupportBtnTapped(_ sender: UIButton) {
        let helpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HelpAndSupportViewController")as? HelpAndSupportViewController
        navigationController?.pushViewController(helpVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func privacyBtnTapped(_ sender: UIButton) {
        let privacyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PrivacyViewController")as? PrivacyViewController
        navigationController?.pushViewController(privacyVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.dismissHamburgerMenu()
    }
    @IBAction func settingBtnTapped(_ sender: UIButton) {
        let settingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingViewController")as? SettingViewController
        navigationController?.pushViewController(settingVC!, animated: true)
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
}
