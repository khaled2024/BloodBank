//
//  UserCustomTF.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit
class UserCustomTF{
    
     func setUpTextField(textField: UITextField , nameTextField: String){
        self.textFieldBorder(textField: textField, nameeditText: nameTextField)
        self.setupPadding(for: textField)
    }
    private func textFieldBorder(textField: UITextField , nameeditText: String){
        textField.layer.borderColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.layer.cornerRadius = textField.frame.height / 2
        textField.layer.borderWidth = 1
        textField.attributedPlaceholder = NSAttributedString(
            string: nameeditText,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.854902029, green: 0.854902029, blue: 0.8549019694, alpha: 1) ]
        )
    }
    private func setupPadding(for textField: UITextField){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = paddingView
        textField.rightViewMode = .always
    }
}



