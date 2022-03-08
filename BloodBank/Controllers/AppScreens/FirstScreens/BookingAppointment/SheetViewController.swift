//
//  SheetViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 08/03/2022.
//

import UIKit

class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    //MARK: - variabels
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    var navManager = NavigationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .large
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    //MARK: - private func
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
//        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")as! TabBarController
//        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
//            window.rootViewController = tabBarController
//            UIView.transition(with: window, duration: 0.7, options: .allowAnimatedContent, animations: nil, completion: nil)
//        }
        navManager.show(screen: .tapBarController, inController: self)
    }
}
