//
//  PrivacyViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    @IBOutlet weak var lbl: UILabel!
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification), name: Notification.Name (Notifications.detailNot), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar.setNavBar(myView: self, title: "Privacy policy".Localized(), viewController: view)
    }
    
    @objc func didGetNotification(_ notification: Notification){
        let patient = notification.object as? Patient
        print(patient?.bloodType ?? "")
        self.lbl.text = patient?.bloodType
        view.backgroundColor = .darkGray
    }
      
}
