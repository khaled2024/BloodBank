//
//  HelpAndSupportViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class HelpAndSupportViewController: UIViewController {
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar.setNavBar(myView: self, title: "Help & Support".Localized(), viewController: view)
    }
    


}
