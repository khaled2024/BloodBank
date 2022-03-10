//
//  FitnessAppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit

class FitnessAppointmentViewController: UIViewController{
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.backItem?.titleView?.isHidden = true
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor =  #colorLiteral(red: 0.9851935506, green: 0.9802264571, blue: 0.9716960788, alpha: 1)
        title = " "
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true

    }
    
    @IBAction func goToBookingVC(_ sender: UIButton) {
        
        let booking = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookingAppointmentViewController")as? BookingAppointmentViewController
        self.navigationController?.pushViewController(booking!, animated: true)
        self.modalPresentationStyle = .fullScreen
        
    }
    

}
