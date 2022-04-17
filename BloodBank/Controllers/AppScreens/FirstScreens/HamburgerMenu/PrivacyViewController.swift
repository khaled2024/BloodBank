//
//  PrivacyViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar.setNavBar(myView: self, title: "Privacy policy".Localized(), viewController: view)
    }
    
}
