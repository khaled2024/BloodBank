//
//  VaccineRequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 04/04/2022.
//

import UIKit
//import CardSlider


class VaccineRequestViewController: UIViewController {
    @IBOutlet weak var takeAlookBtn: UIButton!
    let navBar = NavigationBar()
    let customBtn = UserCustomBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Vaccine request".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        takeAlookBtn.customTitleLbl(btn: takeAlookBtn, text: "الق نظره", fontSize: 19)
        customBtn.confirmBtnSelected(Btn: takeAlookBtn)
        self.navigationItem.backButtonTitle = ""
        
    }
    //MARK: - Private func
    
    
    
    //MARK: - Actions
    @IBAction func takeAlookBtnTapped(_ sender: UIButton) {
        let vaccineCollectionVC = VaccineCollectionViewController.instantiate()
        self.navigationController?.pushViewController(vaccineCollectionVC, animated: true)
    }
}
//MARK: - Extension
