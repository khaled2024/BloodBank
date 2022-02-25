//
//  AppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class AppointmentViewController: UIViewController {
  
    @IBOutlet weak var myView: UIView!
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1)
        navBar.setNavBar(myView: self, title: "المواعيد", viewController: view, navBarColor: #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , bacgroundView: #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.roundedCornerView(corners: [.bottomLeft , .topLeft], radius: myView.frame.size.width/0.2)

    }
}

