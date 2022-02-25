//
//  NotFitAppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit
class NotFitAppointmentViewController: UIViewController {
    @IBOutlet weak var backToHomeScreenBtn: UIButton!
    @IBOutlet weak var informationCenterBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor =  #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1)
    }
    private func backToHomeScreen(){
        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.7, options: .allowAnimatedContent, animations: nil, completion: nil)
        }
    }
    @IBAction func backToHomeScreenBtnTapped(_ sender: UIButton) {
        self.backToHomeScreen()
    }
}
