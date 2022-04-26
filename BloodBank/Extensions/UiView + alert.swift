//
//  UiView + alert.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 29/01/2022.
//

import UIKit

extension UIViewController {
    func showNormalAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func SuccessAlert(title: String,message: String , style: UIAlertAction.Style,completion: ((UIAlertAction)-> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: style, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithSettingBtn(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Setting", style: .destructive, handler: { action in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithCancleBtn(title: String,message: String , style: UIAlertAction.Style,completion: ((UIAlertAction)-> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: style, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancle", style: style, handler: { _ in
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
    
