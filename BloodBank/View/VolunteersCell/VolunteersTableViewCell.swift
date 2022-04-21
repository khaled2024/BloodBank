//
//  VolunteersTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 20/04/2022.
//

import UIKit

class VolunteersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var volunteerImage: UIImageView!
    @IBOutlet weak var volunteerNameLbl: UILabel!
    @IBOutlet weak var volunteerLocationLbl: UILabel!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var VolunteerimageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDesign()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    //MARK: - Functions
    func setUpDesign(){
        VolunteerimageView.layer.cornerRadius = 20.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 3.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
    }
    func config(_ volunteer: Volunteer){
        self.volunteerImage.image = UIImage(named: volunteer.image ?? "")
        self.volunteerNameLbl.text = volunteer.name
        self.volunteerLocationLbl.text = volunteer.location
        self.bloodTypeLbl.text = volunteer.bloodType
    }
    
}
