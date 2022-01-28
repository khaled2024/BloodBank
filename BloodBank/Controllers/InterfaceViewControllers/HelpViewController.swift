//
//  HelpViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/12/2021.
//

import UIKit

class HelpViewController: UIViewController {
    //MARK: - variables
    var gradientBackground = UserGradientBackground()
    var customTF = UserCustomTF()
    var customBtn = UserCustomBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewWillAppear(_ animated: Bool) {
        setUpDesign()
    }
    func setUpDesign(){
        gradientBackground.setGradientBackground(colorTop:#colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , colorBottom: #colorLiteral(red: 1, green: 0.5537948608, blue: 0.5569084883, alpha: 1), view: self.view)
    }
    

}
