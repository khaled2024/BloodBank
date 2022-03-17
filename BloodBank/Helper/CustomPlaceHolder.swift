//
//  CustomPlaceHolder.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/03/2022.
//

import UIKit

class CustomPlaceHolder: UITextField {

    override func awakeFromNib() {
        attributedPlaceholder = NSAttributedString(
            string: placeholder!.description,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) ]
        )
    }

}
