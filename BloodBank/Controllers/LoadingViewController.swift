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
    override func viewDidLoad() {
        super.viewDidLoad()
        isOnBoardingSeen = storageManager.isOnboardingSeen()
    }
    override func viewDidAppear(_ animated: Bool) {
        showInitialScreen()
    }
    private func showInitialScreen(){
        if isOnBoardingSeen{
            navigationManager.show(screen: .mainApp, inController: self)
        }else{
            navigationManager.show(screen: .onboarding, inController: self)
        }
    }
}





