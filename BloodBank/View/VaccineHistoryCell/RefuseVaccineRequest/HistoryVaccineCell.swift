//
//  HistoryVaccineCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/04/2022.
//

import UIKit

class HistoryVaccineCell: UITableViewCell {

    @IBOutlet weak var placeOfReciving: UILabel!
    @IBOutlet weak var timeOfOrder: UILabel!
    @IBOutlet weak var vaccineAmount: UILabel!
    @IBOutlet weak var vaccineName: UILabel!
    @IBOutlet weak var vaccineView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var vaccineImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 3.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        vaccineView.layer.cornerRadius = 20.0
        vaccineImage.layer.cornerRadius = self.vaccineImage.frame.size.width/2
       
    }
    func configure(vaccineName: String , vaccineAmount: String , timeOrderVaccine: String,placeOfOrder: String){
        self.vaccineName.text = vaccineName
        self.vaccineAmount.text = vaccineAmount
        self.timeOfOrder.text = timeOrderVaccine
        self.placeOfReciving.text = placeOfOrder
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
