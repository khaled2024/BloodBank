//
//  NotificationViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 11/02/2022.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navBar.setNavBar(myView: self, title: "الاشعارات", viewController: view)
    }
    
}
