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
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
