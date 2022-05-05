//
//  LastDonateHistoryCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/04/2022.
//

import UIKit

class LastDonateHistoryCell: UITableViewCell {
    @IBOutlet weak var timeOfLastDonationLbl: UILabel!
    @IBOutlet weak var voltImage: UIImageView!
    @IBOutlet weak var vaccineImage: UIImageView!
    @IBOutlet weak var lastDonateView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lastDonateView.layer.shadowColor = UIColor.gray.cgColor
        lastDonateView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        lastDonateView.layer.shadowOpacity = 3.0
        lastDonateView.layer.masksToBounds = false
        lastDonateView.layer.cornerRadius = 20.0
        voltImage.layer.cornerRadius = 20.0
        vaccineImage.layer.cornerRadius = 20.0
    }

    func configure(timeOfLastDonation: String){
        self.timeOfLastDonationLbl.text = timeOfLastDonation
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
