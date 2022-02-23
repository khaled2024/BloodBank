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
        
        navBar.setNavBar(myView: self, title: "سياسه الخصوصيه", viewController: view)
        
        
    }
    
    
    
}
