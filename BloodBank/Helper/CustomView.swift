//
//  CustomView.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/03/2022.
//

import Foundation
import UIKit
class CustomView: UIView{
    let gradient = UserGradientBackground()
    
    func customView(theView: UIView){
        theView.backgroundColor = UIColor(named: "bgIColornsideCell")
        theView.layer.shadowColor = UIColor.darkGray.cgColor
        theView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        theView.layer.shadowOpacity = 3.0
        theView.layer.masksToBounds = false
        theView.layer.cornerRadius = 20.0
    }
    
    func requestView(theView: UIView){
//        gradient.setGradientBackground(colorTop: #colorLiteral(red: 0.895557344, green: 0.1643874943, blue: 0.328651458, alpha: 1) , colorBottom: #colorLiteral(red: 0.9738656878, green: 0.4654597044, blue: 0.4720987082, alpha: 1), view: theView)
        theView.backgroundColor = UIColor(named: "bgIColornsideCell")
        theView.layer.shadowColor = #colorLiteral(red: 0.8185071945, green: 0.2694924176, blue: 0.2871941328, alpha: 1)
        theView.layer.shadowOffset = CGSize(width:5.0, height: 5.0)
        theView.layer.shadowOpacity = 3.0
        theView.layer.masksToBounds = false
        theView.layer.cornerRadius = 20.0
    }
    func vaccineCustomView(theView: UIView){
        theView.layer.shadowColor = UIColor.darkGray.cgColor
        theView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        theView.layer.shadowOpacity = 5.0
        theView.layer.masksToBounds = false
        theView.layer.cornerRadius = 20.0
    }
    func signUpView(theView: UIView){
        theView.layer.shadowColor = #colorLiteral(red: 0.918268621, green: 0.2490310073, blue: 0.3684441447, alpha: 1)
        theView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        theView.layer.shadowOpacity = 5.0
        theView.layer.masksToBounds = false
        theView.layer.cornerRadius = 20.0
    }
    
}


