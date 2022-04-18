//
//  DonateMoneyViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 05/04/2022.
//

import UIKit
import SafariServices

class DonateMoneyViewController: UIViewController {
    @IBOutlet weak var payPalBtn: UIButton!
    @IBOutlet weak var paymentWayLbl: UILabel!
    @IBOutlet weak var donateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var firstMoneyBtn: UIButton!
    @IBOutlet weak var secondMoneyBtn: UIButton!
    @IBOutlet weak var thirdMoneyBtn: UIButton!
    @IBOutlet weak var fourthMoneyBtn: UIButton!
    
    @IBOutlet weak var moneyYF: UITextField!
    @IBOutlet weak var moneySegment: UISegmentedControl!
    let navBar = NavigationBar()
    let customBtn = UserCustomBtn()
    //MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customBtn.confirmBtnNotSelected(Btn: firstMoneyBtn)
        customBtn.confirmBtnNotSelected(Btn: secondMoneyBtn)
        customBtn.confirmBtnNotSelected(Btn: thirdMoneyBtn)
        customBtn.confirmBtnNotSelected(Btn: fourthMoneyBtn)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
    }
    //MARK: - private func
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "Donate Money".Localized(), viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor ,forgroundTitle: UIColor.forgroundTitle, bacgroundView:UIColor.backgroundView)
        moneySegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Almarai-Bold", size: 15)!], for: .normal)
        
    }
    private func loadSafariSite(){
        guard let url = URL(string: URLS.urlSite) else{return}
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true)
    }
    private func checkMoneyBtns(sender: UIButton){
        if sender == firstMoneyBtn{
            print(firstMoneyBtn.titleLabel?.text ?? "")
            customBtn.toggleForBtn(Btn: firstMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: secondMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: thirdMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: fourthMoneyBtn)
        }else if sender == secondMoneyBtn{
            print(secondMoneyBtn.titleLabel?.text ?? "")
            customBtn.toggleForBtn(Btn: secondMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: firstMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: thirdMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: fourthMoneyBtn)
        }else if sender == thirdMoneyBtn{
            print(thirdMoneyBtn.titleLabel?.text ?? "")
            customBtn.toggleForBtn(Btn: thirdMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: firstMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: secondMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: fourthMoneyBtn)
        }else{
            print(fourthMoneyBtn.titleLabel?.text ?? "")
            customBtn.toggleForBtn(Btn: fourthMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: firstMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: thirdMoneyBtn)
            customBtn.confirmBtnNotSelected(Btn: secondMoneyBtn)
        }
    }
    //MARK: - Actions
    @IBAction func payPalBtnTapped(_ sender: UIButton) {
        // here go to web site
        loadSafariSite()
    }
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("مره واحده")
        }else{
            print("شهرياً")
        }
    }
    @IBAction func moneyBtnTapped(_ sender: UIButton) {
        self.checkMoneyBtns(sender: sender)
    }
    @IBAction func moneyTF(_ sender: UITextField) {
        print(moneyYF.text ?? "")
    }
}
