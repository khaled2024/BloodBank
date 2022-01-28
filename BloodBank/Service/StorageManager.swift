//
//  StorageManager.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import Foundation

class StorageManager{
    enum key: String{
        case onboardingSeen
    }
    
    func isOnboardingSeen()-> Bool{
        UserDefaults.standard.bool(forKey: key.onboardingSeen.rawValue)
    }
    func setOnboardingSeen(){
        UserDefaults.standard.set(true, forKey: key.onboardingSeen.rawValue)
    }
    func resetOnboardingSeen(){
        UserDefaults.standard.set(false, forKey: key.onboardingSeen.rawValue)
    }
}
