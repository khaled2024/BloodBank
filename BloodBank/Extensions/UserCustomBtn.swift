//
//  UserCustomBtn.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 18/12/2021.
//

import Foundation
import UIKit
class UserCustomBtn{
    //MARK: - Signleton
    private static let sharedInstance = UserCustomBtn()
    static func shared() ->UserCustomBtn{
        return UserCustomBtn.sharedInstance
    }
    private let def = UserDefaults.standard
    var checkBtn = false
    
    func confirmBtnNotSelected(Btn: UIButton){
        Btn.tintColor = .white
        Btn.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    func confirmBtnSelected(Btn: UIButton){
        Btn.tintColor = .white
        Btn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
    func toggleForBtn(Btn: UIButton){
        if checkBtn == false{
            checkBtn = true
            self.confirmBtnSelected(Btn: Btn)
        }else{
            checkBtn = false
            self.confirmBtnNotSelected(Btn: Btn)
        }
    }
}
