//
//  UiView+Controller.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/03/2022.
//

import UIKit

extension UIViewController{
    static var identifier: String{
        return String(describing: self)
    }
    static func instantiate()-> Self{
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)as! Self
    }
}
