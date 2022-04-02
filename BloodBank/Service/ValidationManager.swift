//
//  ValidationManager.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 02/04/2022.
//

import Foundation
extension String{
    var isValidName: Bool{
        return self.count > 3
    }
    var isValidEmail: Bool{
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: self)
    }
    var isValidMobile: Bool{
        let format = "^01[0125][0-9]{8}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: self)
    }
    var isValidID: Bool{
        let format = "(2|3)[0-9][1-9][0-1][1-9][0-3][1-9]"
//        "(2|3)[0-9][1-9][0-1][1-9][0-3][1-9][0-9][1-9][0-9][1-9][0-9][1-9](0-9)"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: self)
    }
    var isValidPassword: Bool{
        return self.count > 5
    }
    
}
enum SignUpError: Error {
    case isValidEmail
    case isValidName
    case isValidID
    case isValidMobile
    case isValidPassword
}

