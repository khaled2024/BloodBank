//
//  BookingAppointmentViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/02/2022.
//

import UIKit
import MapKit

//MARK: - Variables
class BookingAppointmentViewController: UIViewController {
    @IBOutlet weak var bookingMapView: MKMapView!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankAddressLabel: UILabel!
    @IBOutlet weak var bankAvalabiltyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       setUpDesign()
    }
    //MARK: - private functions
    func setUpDesign(){
        title = "حجز ميعاد"
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1) , .font: UIFont(name: "Almarai-Bold", size: 20)!]
        self.view.backgroundColor =  #colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
//        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(named: "blood-drop"), style: .plain, target: nil, action: nil)
        navigationItem.backButtonTitle = ""
        navigationItem.backBarButtonItem?.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
        self.detailsView.isHidden = true
    }

    //MARK: - Actions
    @IBAction func pickDateTimeBtnTapped(_ sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickDateTimeViewController")as! PickDateTimeViewController, animated: true)
        self.modalPresentationStyle = .fullScreen
        
    }
}

//#colorLiteral(red: 0.9845134616, green: 0.9810839295, blue: 0.9719126821, alpha: 1)
