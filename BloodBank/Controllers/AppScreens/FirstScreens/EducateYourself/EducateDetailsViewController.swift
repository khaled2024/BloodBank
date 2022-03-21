//
//  EducateDetailsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 21/03/2022.
//

import UIKit

class EducateDetailsViewController: UIViewController{
    
    @IBOutlet weak var label: UILabel!
    let navBar = NavigationBar()
    var titleNavBar = ""
    var bloodArticels = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDesign()
        setUpData()
        
    }
    //MARK: - Private func
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: titleNavBar, viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.navBarTintColor, forgroundTitle:UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
 
        
    }
    private func setUpData(){
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 30.0
        let attributedString = NSMutableAttributedString(string: bloodArticels)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraph, range: NSMakeRange(0, attributedString.length))
     
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Almarai-Bold", size: 23)!, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
    }
}
//MARK: - Comments
