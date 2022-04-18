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
    enum key: String{
        case isLoggedIn
        case isNotificationOn
    }
    private let def = UserDefaults.standard
    var isLoggedIn: Bool{
        set{
            def.set(newValue, forKey: key.isLoggedIn.rawValue)
        }
        get{
            guard def.object(forKey: key.isLoggedIn.rawValue) != nil else  {
                return false
            }
            return def.bool(forKey: key.isLoggedIn.rawValue)
        }
    }
    var isNotificationOn: Bool{
        set{
            def.set(newValue, forKey: key.isNotificationOn.rawValue)
        }
        get{
            guard def.object(forKey: key.isNotificationOn.rawValue) != nil else  {
                return false
            }
            return def.bool(forKey: key.isNotificationOn.rawValue)
        }
    }
    
}
