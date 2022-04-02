//
//  LoadingViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit
class LoadingViewController: UIViewController {
    private var isOnBoardingSeen: Bool!
    private let navigationManager = NavigationManager()
    private let storageManager = StorageManager()
    let def = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnBoardingSeen = storageManager.isOnboardingSeen()
        print("OnBoarding seen \(isOnBoardingSeen!)")
    }
    override func viewDidAppear(_ animated: Bool) {
        showInitialScreen()
    }
    //MARK: - functions
    private func showInitialScreen(){
        if isOnBoardingSeen {
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            if let isLoggedIn = def.object(forKey: "isLoggedIn")as? Bool{
                if isLoggedIn == true{
                    print("tapBar")
                    navigationManager.show(screen: .tapBarController, inController: self)
                }else{
                    print("Main")
                    navigationManager.show(screen: .mainApp, inController: self)
                }
            }
        }else{
            navigationManager.show(screen: .onboarding, inController: self)
        }
        
    }
}
