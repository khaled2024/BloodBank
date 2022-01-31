//
//  MainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit
class MainViewController: UIViewController , HambburgerViewControllerDelegate, opacityDelegate{
    //MARK: - Outlets
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var humbergerView: UIView!
    @IBOutlet weak var backViewForHumburger: UIView!
    var hamburgerViewController: HamburgerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        humbergerView.isHidden = true
    }
    //MARK: -  private functions
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
            self.leading.constant = 5
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.2) {
                self.leading.constant = -280
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = true
                self.isHamburgerMenuShown = false
            }
        }
    }
    func backViewForHumburgerObacity() {
        self.backViewForHumburger.layer.opacity = 1
    }
    
    func showSlideMenu(){
        UIView.animate(withDuration: 0.1) {
            self.leading.constant = 10
            self.view.layoutIfNeeded()
        } completion: { status in
            UIView.animate(withDuration: 0.1) {
                self.leading.constant = 0
                self.view.layoutIfNeeded()
            } completion: { status in
                self.humbergerView.isHidden = false
                self.backViewForHumburger.layer.opacity = 0.8
                self.isHamburgerMenuShown = true
            }
        }
    }
    
    //private hamburger movment code
    private var isHamburgerMenuShown: Bool = false
    private var beginPoint: CGFloat = 0.0
    private var diffrence:CGFloat = 0.0
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            if let touch = touches.first{
                let location = touch.location(in: backViewForHumburger)
                beginPoint = location.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            if let touch = touches.first{
                let location = touch.location(in: backViewForHumburger)
                let diffFromBeginPoint = beginPoint-location.x
                if (diffFromBeginPoint > 0 && diffFromBeginPoint < 280){
                    self.leading.constant = -diffFromBeginPoint
                    diffrence = diffFromBeginPoint
                    print("diff is - \(diffFromBeginPoint)")
                }
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(isHamburgerMenuShown){
            
            if (diffrence < 140){
                UIView.animate(withDuration: 0.2) {
                    self.leading.constant = -290
                } completion: { status in
                    self.isHamburgerMenuShown = false
                    self.humbergerView.isHidden = true
                }
                
            }else{
                UIView.animate(withDuration: 0.1) {
                    self.leading.constant = -10
                } completion: { status in
                    self.humbergerView.isHidden = true
                    self.backViewForHumburger.isHidden = false
                }
                
            }
        }
    }
    //MARK: - Actions
    @IBAction func touchOnScreen(_ sender: UITapGestureRecognizer) {
        hideHamburgerMenu()
        backViewForHumburger.layer.opacity = 1
        
    }
    @IBAction func barBtnTapped(_ sender: UIBarButtonItem) {
        showSlideMenu()
    }
}
