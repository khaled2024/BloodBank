//
//  FloatingBtn.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 03/04/2022.
//

import UIKit

class FloatinBtn{
     let floatingBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
         button.backgroundColor = UIColor.navBarTintColor
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        // for radius & shadow
        // button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.4
        return button
    }()
}
