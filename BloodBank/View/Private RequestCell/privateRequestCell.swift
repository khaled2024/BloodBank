//
//  privateRequestCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 29/04/2022.
//

import UIKit

class privateRequestCell: UITableViewCell {
    
    @IBOutlet weak var numOfBagsLbl: UILabel!
    @IBOutlet weak var volunteerNumLbl: UILabel!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var hospitalName: UILabel!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var goingOrderBtn: UIButton!
    @IBOutlet weak var volunteerBtn: UIButton!
    @IBOutlet weak var donorImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bloodView: UIView!
    let customBtn = UserCustomBtn()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       setDesign()
    }
    private func setDesign(){
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cardView.layer.shadowOpacity = 5.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        donorImage.layer.cornerRadius = self.donorImage.frame.size.width/2
        bloodView.roundedCornerView(corners: [.topLeft , .bottomLeft], radius: bloodView.frame.size.width/0.2)
        customBtn.shadowBtn(btn: saveBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: goingOrderBtn, colorShadow: UIColor.gray.cgColor)
        customBtn.shadowBtn(btn: volunteerBtn, colorShadow: UIColor.gray.cgColor)
    }
    func configure(name: String, bloodType: String, address: String, time: String, description: String , donorImage: String,volunteers: String, numberOfBags: String){
        patientName.text = name
        bloodTypeLbl.text = bloodType
        hospitalName.text = address
        timeLbl.text = time
        messageLbl.text = description
        volunteerNumLbl.text = volunteers
        numOfBagsLbl.text = numberOfBags
        //  let imageFromSite = donorImage.asURL
        self.donorImage.load(urlString: donorImage)
    }
    
}
