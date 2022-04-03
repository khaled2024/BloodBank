//
//  YourStoryTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 03/04/2022.
//

import UIKit

class YourStoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var donorImage: UIImageView!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var NameDonorLbl: UILabel!
    let customView = CustomView()
    override func awakeFromNib() {
        super.awakeFromNib()
        donorImage.layer.cornerRadius = donorImage.frame.size.width/2
        customView.customView(theView: insideView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(image: UIImage , donorName: String , description: String){
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: donorName, attributes: underlineAttribute)
        NameDonorLbl.attributedText = underlineAttributedString
        self.donorImage.image = image
        self.NameDonorLbl.text = donorName
        self.DescriptionLbl.text = description
    }
    
}
