//
//  RequestsTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 10/03/2022.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    @IBOutlet weak var donorImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var bloodTypeLbl: UILabel!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var numberOfBagsLbl: UILabel!
    let shadowBtn = UserCustomBtn()
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDesign()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //MARK: - private func
    private func setUpDesign(){
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        cardView.layer.shadowOpacity = 5.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        donorImage.layer.cornerRadius = self.donorImage.frame.size.width/2
        
//        shadowBtn.shadowBtn(btn: likeBtn)
//        shadowBtn.shadowBtn(btn: commentBtn)
//        shadowBtn.shadowBtn(btn: shareBtn)
        
        insideView.roundedCornerView(corners: [.topLeft , .bottomLeft], radius: insideView.frame.size.width/0.2)
    }
    func configure(name: String, bloodType: String, address: String, time: String, description: String , donorImage: String, numberOfBags: String){
        patientNameLbl.text = name
        bloodTypeLbl.text = bloodType
        addressLbl.text = address
        timeLbl.text = time
        descriptionLbl.text = description
        numberOfBagsLbl.text = numberOfBags
//        let imageFromSite = donorImage.asURL
        self.donorImage.load(urlString: donorImage)
    }
    
    //MARK: - Actions
    
}
