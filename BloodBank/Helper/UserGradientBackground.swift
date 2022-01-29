//
//  UserGradientBackground.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/01/2022.
//

import UIKit
class UserGradientBackground{
    
    func setGradientBackground(colorTop: UIColor,colorBottom: UIColor , view: UIView) {
        let colorTop =  colorTop.cgColor
        let colorBottom = colorBottom.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}

