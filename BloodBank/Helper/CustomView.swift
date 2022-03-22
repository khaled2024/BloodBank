//
//  CustomView.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/03/2022.
//

import Foundation
import UIKit
class CustomView: UIView{
    func customView(theView: UIView){
        theView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        theView.layer.shadowColor = UIColor.gray.cgColor
        theView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        theView.layer.shadowOpacity = 3.0
        theView.layer.masksToBounds = false
        theView.layer.cornerRadius = 20.0
    }
    
}
