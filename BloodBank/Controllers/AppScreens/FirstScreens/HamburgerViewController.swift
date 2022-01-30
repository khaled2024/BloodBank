//
//  HamburgerViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 30/01/2022.
//

import UIKit
protocol HambburgerViewControllerDelegate{
    func hideHamburgerMenu()
}
protocol opacityDelegate {
    func backViewForHumburgerObacity()
}

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var humburgerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var delegate: HambburgerViewControllerDelegate?
    var delegate2: opacityDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHumburger()
        
    }
    private func setUpHumburger(){
        self.humburgerView.layer.cornerRadius = 40
        self.humburgerView.clipsToBounds = true
        
        self.imageView.layer.cornerRadius = 40
        self.imageView.clipsToBounds = true

    }
    
    @IBAction func helloworldBtnTapped(_ sender: UIButton) {
        // dismiss humbuger menu
        self.delegate?.hideHamburgerMenu()
        self.delegate2?.backViewForHumburgerObacity()
    }
    

    @IBAction func logOutBtnTapped(_ sender: UIButton) {
        let logOutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogOutViewController")as? LogOutViewController
        navigationController?.pushViewController(logOutVC!, animated: true)
        self.modalTransitionStyle = .partialCurl
        self.delegate?.hideHamburgerMenu()
    }
    

}
