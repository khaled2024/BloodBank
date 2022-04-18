//
//  DonationHistoryViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class DonationHistoryViewController: UIViewController {
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Donation History".Localized(), viewController: view)
    }
    
}
