//
//  MainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit

class MainViewController: UIViewController , HambburgerViewControllerDelegate, opacityDelegate{
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var humbergerView: UIView!
    @IBOutlet weak var backViewForHumburger: UIView!
    var hamburgerViewController: HamburgerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        humbergerView.isHidden = true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "hamburgerSegue"){
            if let controller = segue.destination as? HamburgerViewController{
                self.hamburgerViewController = controller
                self.hamburgerViewController?.delegate = self
                self.hamburgerViewController?.delegate2 = self
            }
        }
    }
    func hideHamburgerMenu() {
        UIView.animate(withDuration: 0.2) {
            self.leading.constant = 10
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.2) {
                self.leading.constant = -299
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = true
            }
        }
    }
    func backViewForHumburgerObacity() {
        self.backViewForHumburger.layer.opacity = 1
    }
    
    func showSlideMenu(){
        UIView.animate(withDuration: 0.2) {
            self.leading.constant = 5
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.2) {
                self.leading.constant = 0
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = false
                self.backViewForHumburger.layer.opacity = 0.8
            }
        }
    }
    @IBAction func touchOnScreen(_ sender: UITapGestureRecognizer) {
        hideHamburgerMenu()
        backViewForHumburger.layer.opacity = 1
    }
  

    @IBAction func barBtnTapped(_ sender: UIBarButtonItem) {
        showSlideMenu()
        
    }
   
}
