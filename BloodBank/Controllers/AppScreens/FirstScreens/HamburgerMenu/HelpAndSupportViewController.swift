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

        navBar.setNavBar(myView: self, title: "المساعده والدعم", viewController: view)
        
    }
    


}
