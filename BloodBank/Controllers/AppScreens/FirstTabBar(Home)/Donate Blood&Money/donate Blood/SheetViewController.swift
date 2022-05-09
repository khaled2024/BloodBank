//
//  SheetViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 08/03/2022.

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
        navManager.show(screen: .tapBarController, inController: self)
    }
}
