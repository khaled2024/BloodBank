//
//  AppointmentMainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class AppointmentMainViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification), name: Notification.Name ("test"), object: nil)

    }
    
    @objc func didGetNotification(_ notification: Notification){
        let bloodBankName = notification.object as! String?
//        self.patient.append(Patient(name: "", bloodType: "", address: bloodBankName ?? "", time: "", description: ""))
        self.label.text = bloodBankName
        print(bloodBankName!)
//        tableView.reloadData()
    }

}
