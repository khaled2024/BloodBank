//
//  VaccineCollectionViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 14/04/2022.
//

import UIKit

class VaccineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subTitleVaccineLbl: UILabel!
    @IBOutlet weak var titleVaccineLbl: UILabel!
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    func setUpCell(vaccineItem: VaccineItem){
        self.imageView.image = vaccineItem.imageVaccine
        self.titleVaccineLbl.text = vaccineItem.titleVaccine
        self.subTitleVaccineLbl.text = vaccineItem.subTitleVaccine
        self.backgroundColorView.layer.cornerRadius = 10.0
        self.backgroundColorView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
        
    }
}



