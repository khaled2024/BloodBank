//
//  MainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  

    @IBAction func BtnTapped(_ sender: UIButton) {
        let hello1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Hello1")as! Hello1
        navigationController?.pushViewController(hello1, animated: true)
    }
}
