//
//  UILable+Font.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 31/03/2022.
//

import Foundation
import UIKit

extension UILabel{
    func customLblFont(lbl: UILabel, fontSize: CGFloat,text: String){
         lbl.attributedText = NSAttributedString(string: text.Localized(), attributes: [.font: UIFont(name: "Almarai", size: fontSize)!])
    }
}

