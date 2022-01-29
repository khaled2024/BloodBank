//
//  UiView + alert.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 29/01/2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func SuccessAlert(message: String , completion: ((UIAlertAction)-> Void)?){
        let alert = UIAlertController(title: "Congratulations", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
