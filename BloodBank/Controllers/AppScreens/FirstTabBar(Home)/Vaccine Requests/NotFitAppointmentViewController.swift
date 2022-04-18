//
//  NotFitAppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit
class NotFitAppointmentViewController: UIViewController {
    var customBtn = UserCustomBtn()
    var navManager = NavigationManager()
    @IBOutlet weak var backToHomeScreenBtn: UIButton!
    @IBOutlet weak var informationCenterBtn: UIButton!
    
    override func viewDidLoad() {
        setUpDesign()
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = ""
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true

    }
    //MARK: - Private functions
    private func setUpDesign(){
        view.backgroundColor =  #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1)
        customBtn.customBtn(Btn: backToHomeScreenBtn, tintColor: .black, borderColor: CGColor(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bgColor: .clear)
    }
    //MARK: - Actions
    @IBAction func backToHomeScreenBtnTapped(_ sender: UIButton) {
        navManager.show(screen: .tapBarController, inController: self)
    }
    @IBAction func informationCenterBtnTapped(_ sender: UIButton) {
        self.navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InformationCenterViewController")as! InformationCenterViewController, animated: true)
    }
}
//MARK: - comments
//let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
//        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
//            window.rootViewController = tabBarController
//            UIView.transition(with: window, duration: 0.7, options: .allowAnimatedContent, animations: nil, completion: nil)
//        }
