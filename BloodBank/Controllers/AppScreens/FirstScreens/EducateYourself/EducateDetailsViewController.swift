//
//  EducateDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 21/03/2022.
//

import UIKit

class EducateDetailsViewController: UIViewController {
    let navBar = NavigationBar()
    var titleNavBar = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
    }
    
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: titleNavBar, viewController: view, navBarColor: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1), bacgroundView: #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1))
    }
    private func setUpData(){
        //
    }
}
