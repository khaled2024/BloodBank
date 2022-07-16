//
//  VaccineRequestViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 04/04/2022.
//

import UIKit
//import CardSlider


class VaccineRequestViewController: UIViewController {
    @IBOutlet weak var nextImageAra: UIImageView!
    @IBOutlet weak var nextBtnAra: UIButton!
    @IBOutlet weak var nextImageEng: UIImageView!
    @IBOutlet weak var nextBtnEng: UIButton!
    @IBOutlet weak var takeAlookBtn: UIButton!
    let navBar = NavigationBar()
    let customBtn = UserCustomBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Vaccine request".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        takeAlookBtn.customTitleLbl(btn: takeAlookBtn, text: "القي نظره", fontSize: 19)
        customBtn.confirmBtnSelected(Btn: takeAlookBtn)
        btnChangesInViewWithLang()
        
    }
    //MARK: - Private func
    
    private func btnChangesInViewWithLang(){
        let currentLang = Locale.current.languageCode
        if currentLang == "en"{
            self.nextImageAra.isHidden = true
            self.nextBtnAra.isHidden = true
            print("current language:\(currentLang!)")
        }else{
            self.nextImageEng.isHidden = true
            self.nextBtnEng.isHidden = true
        }
    }
    //MARK: - Actions
    @IBAction func takeAlookBtnTapped(_ sender: UIButton) {
        let vaccineCollectionVC = VaccineCollectionViewController.instantiate()
        self.navigationController?.pushViewController(vaccineCollectionVC, animated: true)
    }
}
