//
//  HelpAndSupportViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit
import MessageUI
import Lottie


class HelpAndSupportViewController: UIViewController {
    @IBOutlet weak var emailSupportBtn: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    let navBar = NavigationBar()
    let currentLang = Locale.current.languageCode
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentLang!)
        if currentLang == "en"{
            emailSupportBtn.setTitle("Email Support", for: .normal)
        }else{
            emailSupportBtn.setTitle("دعم البريد الاكتروني", for: .normal)
        }
        
        self.lottieSendEmail()
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar.setNavBar(myView: self, title: "Connect with us".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        
    }
    //MARK: - private func
    private func lottieSendEmail(){
        let animation = Animation.named("LottieEmailSend")
        animationView.animation = animation
        animationView.loopMode = .loop
        if !animationView.isAnimationPlaying{
            animationView.play()
        }
    }
    private func showEmailDialoge(){
        guard MFMailComposeViewController.canSendMail() else{
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["info@blood-bank.life"])
        composer.setSubject("help!")
        composer.setMessageBody("hello world>:)", isHTML: false)
        present(composer, animated: true)
    }
    
    
    
    //MARK: - actions
    @IBAction func sendEmailBtnTapped(_ sender: UIButton) {
        self.showEmailDialoge()
        
    }
}
//MARK: - extension
extension HelpAndSupportViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if error != nil {
            controller.dismiss(animated: true)
        }
        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            showNormalAlert(title: "", message: "Saved")
        case .sent:
            showNormalAlert(title: "", message: "Message Sent")
        case .failed:
            print("failed")
        @unknown default:
            print("default error")
        }
        controller.dismiss(animated: true)
    }
}
