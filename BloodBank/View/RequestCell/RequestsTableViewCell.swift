//
//  RequestsTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 10/03/2022.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var donateBtn: UIButton!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    //MARK: - private func
    private func setUpDesign(){
        
        donateBtn.backgroundColor = #colorLiteral(red: 0.9430654645, green: 0.5580121875, blue: 0.5767285228, alpha: 1)
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 3.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        
        donateBtn.layer.shadowColor = UIColor.gray.cgColor
        donateBtn.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        donateBtn.layer.shadowOpacity = 2.0
        donateBtn.layer.masksToBounds = false
        
        insideView.roundedCornerView(corners: [.topLeft], radius: insideView.frame.size.width/0.2)
    }
     func configure(name: String, bloodType: String, address: String, time: String, description: String){
        patientNameLbl.text = name
        bloodTypeLbl.text = bloodType
        addressLbl.text = address
        timeLbl.text = time
        descriptionLbl.text = description
    }
    
    //MARK: - Actions
    
    @IBAction func donateBtnTapped(_ sender: UIButton) {
        donateBtn.backgroundColor = #colorLiteral(red: 0.9424516559, green: 0.3613950312, blue: 0.3825939894, alpha: 1)
        
    }
    
}
