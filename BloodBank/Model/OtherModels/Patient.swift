//
//  Patient.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 11/03/2022.
//

import Foundation
struct Patient{
    let donorImage: String?
    let name: String?
    let bloodType: String?
    let address: String?
    let time: String?
    let description: String?
    let volunteer: String?
    
    init(name: String, bloodType: String, address: String, time: String, description: String ,donorImage:String, volunteer: String ) {
        self.name = name
        self.bloodType = bloodType
        self.address = address
        self.time = time
        self.description = description
        self.donorImage = donorImage
        self.volunteer = volunteer
    }
    
}
