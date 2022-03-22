//
//  CoronaStatsViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 22/03/2022.
//

import UIKit

class CoronaStatsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var statsViewConfirmed: UIView!
    @IBOutlet weak var coronaview: UIView!
    @IBOutlet weak var statsViewRecoverd: UIView!
    @IBOutlet weak var statsViewDeath: UIView!
    @IBOutlet weak var countryConfirmedStats: UIView!
    @IBOutlet weak var countryRecoveredStats: UIView!
    @IBOutlet weak var countryDeathsStats: UIView!
    let navBar = NavigationBar()
    let customView = CustomView()
    //MARK: - lifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUpDesign()
    }
    //MARK: - private func
    private func setUpDesign(){
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: UIColor.navBarColor, navBarTintColor: UIColor.white, forgroundTitle: UIColor.forgroundTitle, bacgroundView: UIColor.backgroundView)
        self.navigationController?.navigationBar.backgroundColor = .clear
//        let currentLang = Locale.current.languageCode
//        if  currentLang == "en" {
//            coronaview.roundedCornerView(corners: [.bottomLeft ], radius: coronaview.frame.size.width/6)
//        }else{
//            coronaview.roundedCornerView(corners: [.bottomRight ], radius: coronaview.frame.size.width/6)
        //        }
        customView.customView(theView: statsViewConfirmed)
        customView.customView(theView: statsViewDeath)
        customView.customView(theView: statsViewRecoverd)
        customView.customView(theView: countryConfirmedStats)
        customView.customView(theView: countryRecoveredStats)
        customView.customView(theView: countryDeathsStats)
    }
}
