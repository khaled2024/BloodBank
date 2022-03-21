//
//  AppointmentMainViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit

class NotificationsMainViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification), name: Notification.Name (Notifications.detailNot), object: nil)

    }
    @objc func didGetNotification(_ notification: Notification){
        let patient = notification.object as? Patient
        label.text = patient?.time
        view.backgroundColor = .darkGray
    }
    


}
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
