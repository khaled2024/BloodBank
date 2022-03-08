//
//  InformationCenterViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit

class InformationCenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "مركز المعلومات"
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
        self.tabBarController?.tabBar.isHidden = false

    }
    


}
