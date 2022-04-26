//
//  favoriteTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 24/04/2022.
//

import UIKit

class favoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var donorImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 3.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        donorImage.layer.cornerRadius = self.donorImage.frame.size.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
