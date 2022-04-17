//
//  BloodOrderCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 17/04/2022.
//

import UIKit

class BloodOrderCell: UITableViewCell {

    @IBOutlet weak var voltImage: UIImageView!
    @IBOutlet weak var vaccineImage: UIImageView!
    @IBOutlet weak var bloodOrderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        bloodOrderView.layer.shadowColor = UIColor.gray.cgColor
        bloodOrderView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        bloodOrderView.layer.shadowOpacity = 3.0
        bloodOrderView.layer.masksToBounds = false
        bloodOrderView.layer.cornerRadius = 20.0
        voltImage.layer.cornerRadius = 20.0
        vaccineImage.layer.cornerRadius = 20.0
       
    }
    
}
