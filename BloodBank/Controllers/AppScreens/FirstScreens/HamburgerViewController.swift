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
    //MARK: - outlets
    @IBOutlet weak var humburgerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var delegate: HambburgerViewControllerDelegate?
    var delegate2: opacityDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHumburger()
        
    }
    //MARK: - private functions
    private func setUpHumburger(){
        self.humburgerView.layer.cornerRadius = 20
        self.humburgerView.clipsToBounds = true

        self.imageView.layer.cornerRadius = 50
        self.imageView.clipsToBounds = true

    }
//    MARK: - Actions
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
