//
//  VaccineRequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 04/04/2022.
//

import UIKit

class VaccineRequestViewController: UIViewController {
    let navBar = NavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Vaccine request".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        

    }
    

}
