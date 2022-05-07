//
//  favoriteTableViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 24/04/2022.
//

import UIKit

class favoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var bookMarkImage: UIImageView!
    @IBOutlet weak var bloodBagsLbl: UILabel!
    @IBOutlet weak var volunteerLbl: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var bloodType: UILabel!
    @IBOutlet weak var bloodView: UIView!
    @IBOutlet weak var donorImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    var requestId: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 3.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 20.0
        donorImage.layer.cornerRadius = self.donorImage.frame.size.width/2
        bloodView.roundedCornerView(corners: [.topLeft , .bottomLeft], radius: bloodView.frame.size.width/0.2)
        
    }

    func configure(bloodBags: String , volunteer: String,message: String , time: String , address: String , name: String , bloodType: String , bloodImage: String){
        self.userName.text = name
        self.bloodType.text = bloodType
        self.volunteerLbl.text = volunteer
        self.message.text = message
        self.time.text = time
        self.addressLbl.text = address
        self.donorImage.image = UIImage(named: bloodImage)
        self.bloodBagsLbl.text = bloodBags
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func nonSavedRequest(_ sender: UIButton) {
        print(" request id : \(self.requestId ?? "" ) ")
        self.bookMarkImage.image = UIImage(systemName: "bookmark")
        print("removed from favorite")
        
        removeRequest()
    }
    private func removeRequest(){
        ApiService.sharedService.deleteFavoriteRequest(id: requestId)
    }
}
