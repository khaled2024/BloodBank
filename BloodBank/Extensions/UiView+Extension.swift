//
//  UiView+Extension.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit
extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get{
            return self.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
//rounded corner radius in spacifc corners
extension UIView{
    func roundedCornerView(corners: UIRectCorner , radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: .init(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
