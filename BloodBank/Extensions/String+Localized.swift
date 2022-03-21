//
//  String+Localized.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 21/03/2022.
//

import Foundation
extension String{
    func Localized()-> String{
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
