//
//  UiButtonTitleLbl+Font.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 02/04/2022.
//

import Foundation
import UIKit
extension UIButton{
    func customTitleLbl(btn: UIButton , text: String, fontSize: CGFloat){
        btn.titleLabel?.attributedText = NSAttributedString(string: text.Localized(), attributes: [.font: UIFont(name: "Almarai-Bold", size: fontSize)! , .foregroundColor : UIColor.white])
        
//        btn.titleLabel?.text = text.Localized()
//        btn.tintColor = .white
//        btn.titleLabel?.font = UIFont(name: "Almarai-Bold".Localized(), size: fontSize)
    }
}
