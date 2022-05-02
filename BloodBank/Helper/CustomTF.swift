//
//  CustomTF.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/03/2022.
//

import UIKit

class CustomTF: UITextField {

    override func awakeFromNib() {
        layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        attributedPlaceholder = NSAttributedString(
            string: placeholder!.description,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) ]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        leftView = paddingView
        leftViewMode = .always
        rightView = paddingView
        rightViewMode = .always
    }

}

class myCustomTF: UITextField {

    override func awakeFromNib() {
        layer.borderColor =  #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        layer.cornerRadius = frame.height / 3
        layer.borderWidth = 1
        attributedPlaceholder = NSAttributedString(
            string: placeholder!.description,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ]
        )
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftView = paddingView
        leftViewMode = .always
        rightView = paddingView
        rightViewMode = .always
    }

}
