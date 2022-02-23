//
//  RequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class RequestViewController: UIViewController {
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Requests"
        navBar.setNavBar(myView: self, title: "Requests", viewController: view)
    }

   

}
