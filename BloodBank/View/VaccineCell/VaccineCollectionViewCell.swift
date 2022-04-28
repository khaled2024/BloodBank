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
    
    func setUpCell(vaccineItem: VaccineData,random:Int){
       
        self.imageView.image = UIImage(named: "vaccineImage\(random)")
        self.titleVaccineLbl.text = vaccineItem.trade_name
        self.subTitleVaccineLbl.text = vaccineItem.scientific_name
        self.backgroundColorView.layer.cornerRadius = 10.0
        self.backgroundColorView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 10.0
        self.imageView.layer.masksToBounds = true
        
    }
}



