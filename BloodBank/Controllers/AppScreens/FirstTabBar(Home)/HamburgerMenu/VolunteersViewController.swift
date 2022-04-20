//
//  VolunteersViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 19/04/2022.
//

import UIKit

class VolunteersViewController: UIViewController {
let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDesign()
    }
    
    private func setUpDesign(){
       
        self.tabBarController?.tabBar.isHidden = false
        navBar.setNavBar(myView: self, title: "volunteers".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
    }

}
