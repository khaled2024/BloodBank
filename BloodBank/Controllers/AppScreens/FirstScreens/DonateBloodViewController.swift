//
//  DonateBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class DonateBloodViewController: UIViewController {

    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "التبرع بالدم", viewController: view)
    }
    

   

}
