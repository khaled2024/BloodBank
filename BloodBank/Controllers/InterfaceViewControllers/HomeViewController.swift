//
//  HomeViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - outlets
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "isLoggedIn")

    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    //MARK: - Actions
    @IBAction func CreateBtnTapped(_ sender: UIButton) {
        
    }
    @IBAction func LoginBtnTapped(_ sender: UIButton) {
        
    }
    @IBAction func HelpBtnTapped(_ sender: UIButton) {
        
    }
}
