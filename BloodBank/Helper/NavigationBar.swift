//
//  NavigationBar.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import Foundation
import UIKit

class NavigationBar: UINavigationController{
    func setNavBar(myView: UIViewController,title: String , viewController: UIView){
        myView.title = title
        myView.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        myView.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        myView.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) , .font: UIFont(name: "Almarai", size: 20)!]
        viewController.backgroundColor =  #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
    func setNavBar(myView: UIViewController,title: String , viewController: UIView , navBarColor: UIColor , navBarTintColor: UIColor , forgroundTitle: UIColor , bacgroundView: UIColor){
        myView.title = title
        myView.navigationController?.navigationBar.backgroundColor = navBarColor
        myView.navigationController?.navigationBar.tintColor = navBarTintColor
        myView.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: forgroundTitle , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        viewController.backgroundColor = bacgroundView
    }
}
