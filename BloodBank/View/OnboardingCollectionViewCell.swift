//
//  OnboardingCollectionViewCell.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 15/12/2021.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var slideImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    //MARK: - Functions

    
    func setUp(slide: OnboardingSlide){
        self.slideImageView.image = slide.Image
        self.titleLabel.text = slide.title
        self.descriptionLabel.text = slide.description
    }
    
}
