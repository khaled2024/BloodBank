//
//  NavigationManager.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit


class NavigationManager{
    
    enum Screen{
        case onboarding
        case mainApp
        case tapBarController
    }
    
    func show(screen: Screen, inController: UIViewController){
        var viewContoller: UIViewController!

        switch screen {
        case .onboarding:
            viewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Identifier.OnBoardingVC)
        case .mainApp:
            viewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Identifier.HomeNC)
        case .tapBarController:
            viewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        }
    
        if let sceneDelegate = inController.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = viewContoller
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
