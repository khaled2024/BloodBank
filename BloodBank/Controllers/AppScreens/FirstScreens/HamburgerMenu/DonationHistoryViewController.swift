//
//  DonationHistoryViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class DonationHistoryViewController: UIViewController {
    
    @IBOutlet weak var btnCard2: UIButton!
    @IBOutlet weak var btnCard1: UIButton!
    
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "Donation History".Localized(), viewController: view)
 }
    func animated(){
        UIView.animate(withDuration: 0.5) {
            self.btnCard1.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.5){
                    self.btnCard1.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.btnCard2.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1)
        } completion: { completed in
            if completed{
                UIView.animate(withDuration: 0.3){
                    self.btnCard2.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }
            }
        }

    }
    

    @IBAction func btnTapped(_ sender: UIButton) {
        animated()
    }
    
}
