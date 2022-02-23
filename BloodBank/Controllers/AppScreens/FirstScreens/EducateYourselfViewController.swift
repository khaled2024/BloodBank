//
//  EducateYourselfViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class EducateYourselfViewController: UIViewController {

    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "تعلم بنفسك", viewController: view)

        
    }
    

   

}
