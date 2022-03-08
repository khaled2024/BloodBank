//
//  AppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 06/02/2022.
//

import UIKit

class AppointmentViewController: UIViewController {
    
    //MARK: - Variables
    let navBar = NavigationBar()
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var nextViewAppointment: UIButton!
    @IBOutlet weak var yesGoodHealth: UIButton!
    @IBOutlet weak var noGoodHealth: UIButton!
    @IBOutlet weak var yesKiloGram: UIButton!
    @IBOutlet weak var noKiloGram: UIButton!
    @IBOutlet weak var noDays: UIButton!
    @IBOutlet weak var yesDays: UIButton!
    @IBOutlet weak var yesTattoo: UIButton!
    @IBOutlet weak var noTattoo: UIButton!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonTags()
        
        navBar.setNavBar(myView: self, title: "", viewController: view, navBarColor: #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1), navBarTintColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , forgroundTitle: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , bacgroundView: #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myView.roundedCornerView(corners: [.bottomLeft , .topLeft], radius: myView.frame.size.width/0.2)
        
    }
    //MARK: - Private functions
    private func buttonTags(){
        self.yesGoodHealth.tag = 1
        self.noGoodHealth.tag = 2
        self.yesKiloGram.tag = 3
        self.noKiloGram.tag = 4
        self.yesDays.tag = 5
        self.noDays.tag = 6
        self.yesTattoo.tag = 7
        self.noTattoo.tag = 8
    }
    private func FitnessScreen(){
        let fitness = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FitnessAppointmentViewController")as! FitnessAppointmentViewController
        navigationController?.pushViewController(fitness, animated: true)
        self.modalPresentationStyle = .fullScreen
    }
    private func NotFitnessScreen(){
        let notFitness = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotFitAppointmentViewController")as! NotFitAppointmentViewController
        navigationController?.pushViewController(notFitness, animated: true)
        self.modalPresentationStyle = .fullScreen
    }
    //MARK: - Actions
    
    @IBAction func nextViewBtnTapped(_ sender: UIButton) {
        let buttonSender = sender.tag
        if sender == nextViewAppointment{
            self.insideView.transform = CGAffineTransform(translationX: -350, y: 0)
        }else if buttonSender == 1{
            self.insideView.transform = CGAffineTransform(translationX: -750, y: 0)
        }else if buttonSender == 3{
            self.insideView.transform = CGAffineTransform(translationX: -1150, y: 0)
        }else if buttonSender == 6{
            self.insideView.transform = CGAffineTransform(translationX: -1550, y: 0)
        }else if buttonSender == 8{
            self.FitnessScreen()
        }
    }
    
    @IBAction func failTest(_ sender: UIButton) {
        let buttonSender = sender.tag
        if buttonSender == 2 || buttonSender == 4 || buttonSender == 5 || buttonSender == 7{
            self.NotFitnessScreen()
        }
    }
}


//MARK: - Comments


