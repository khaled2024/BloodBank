//
//  UserCustomBtn.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
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
    func customBtn(Btn: UIButton , tintColor: UIColor , borderColor: CGColor , bgColor: UIColor){
        Btn.tintColor = tintColor
        Btn.layer.borderColor = borderColor
        Btn.backgroundColor = bgColor
        Btn.layer.borderWidth = 1.5
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
    
    func TintColorForBtn(Btn: UIButton){
        if checkBtn == false{
            checkBtn = true
            Btn.tintColor = #colorLiteral(red: 0.6743947268, green: 0, blue: 0.1404457688, alpha: 1)
        }else{
            checkBtn = false
            Btn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
     func setUpBtnFont(btn: UIButton , text: String){
         btn.setTitle(text, for: .normal)
         btn.titleLabel?.font = UIFont(name: "Almarai", size: 20)
    }
    func shadowBtn(btn: UIButton){
        btn.layer.shadowColor = UIColor.darkGray.cgColor
        btn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        btn.layer.shadowOpacity = 3.0
        btn.layer.masksToBounds = false
        btn.layer.cornerRadius = 15.0
    }
}
