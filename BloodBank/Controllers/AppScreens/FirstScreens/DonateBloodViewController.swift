//
//  DonateBloodViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 23/02/2022.
//

import UIKit
//import Lottie

class DonateBloodViewController: UIViewController {
    @IBOutlet weak var animationView: UIImageView?
    let navBar = NavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setNavBar(myView: self, title: "التبرع بالدم", viewController: view)
        // here AnimationView
//        LottieAnimation()
        
    }
//    private func LottieAnimation(){
//        let animationView = AnimationView(name: "97383-yellow-delivery-guy")
//        animationView.frame = CGRect(x: 0, y: 0, width: 350, height: 350)
//        animationView.center = self.view.center
//        animationView.contentMode = .scaleAspectFit
//        view.addSubview(animationView)
//        animationView.play()
//        animationView.loopMode = .loop
//    }
}
