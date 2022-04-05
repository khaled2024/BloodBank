//
//  DonateMoneyViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 05/04/2022.
//

import UIKit

class DonateMoneyViewController: UIViewController {
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Donate Money".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        
    }
  

}
