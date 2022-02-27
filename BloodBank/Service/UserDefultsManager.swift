//
//  UserDefultsManager.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 26/02/2022.
//

import Foundation
class UserDefultsManager{
    //MARK: - Signleton
    private static let sharedInstance = UserDefultsManager()
    static func shared() ->UserDefultsManager{
        return UserDefultsManager.sharedInstance
    }
    //MARK: - variabels
    private let def = UserDefaults.standard
    var isLoggedIn: Bool{
        set{
            def.set(newValue, forKey: "isLoggedIn")
        }
        get{
            guard def.object(forKey: "isLoggedIn") != nil else  {
                return false
            }
            return def.bool(forKey: "isLoggedIn")
        }
    }
}
