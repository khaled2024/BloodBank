//
//  HomeNCViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/02/2022.
//

import UIKit

class HomeNCViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}
