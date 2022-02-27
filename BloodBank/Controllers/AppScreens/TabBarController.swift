//
//  TabBarController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 29/01/2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        ChangeRadiusOfTabbar()
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.4037812054, green: 0.4088639319, blue: 0.4087744653, alpha: 1)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        self.ChangeHeightOfTabbar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(true, forKey: "isLoggedIn")

    }
    
    
    //MARK: - private functions
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.SimpleAnnimationWhenSelectItem(item)
    }
    
    // the height of the tapBar
    
    private func ChangeHeightOfTabbar(){
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 100
            tabFrame.origin.y       = view.frame.size.height - 100
            tabBar.frame            = tabFrame
        }
    }
    // the radius of tabBar
    private func ChangeRadiusOfTabbar(){
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    // animation of tabBar Item
    private func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let timeInterval: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
    
}
