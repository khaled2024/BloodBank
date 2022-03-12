//
//  DetailsCellViewController.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/03/2022.
//

import UIKit

class DetailsCellViewController: UIViewController, UISheetPresentationControllerDelegate  {
    //MARK: - variabels
    
    @IBOutlet weak var descriptionDetailLbl: UILabel!
    @IBOutlet weak var timeDetailLbl: UILabel!
    @IBOutlet weak var addressDetailLbl: UILabel!
    @IBOutlet weak var bloodTypeDetailLbl: UILabel!
    @IBOutlet weak var patientDetailLbl: UILabel!
    
    var myPatient: Patient!
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpSheetPresentation()
        setUpData()
    }
    
    //MARK: - Private func
    private func setUpSheetPresentation(){
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    private func setUpData(){
        patientDetailLbl.text = myPatient.name
        bloodTypeDetailLbl.text = myPatient.bloodType
        addressDetailLbl.text = myPatient.address
        timeDetailLbl.text = myPatient.time
        descriptionDetailLbl.text = myPatient.description
    }
    
    //MARK: - Actions
    @IBAction func donateBtnTapped(_ sender: UIButton) {
        self.SuccessAlert(title: "احسنت O_o", message: "تم التبرع بنجاح.", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func sharingBtnTapped(_ sender: UIButton) {
        
    }
    @IBAction func phoneBtnTapped(_ sender: UIButton) {
        
    }
}
