//
//  Patient.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 11/03/2022.
//

import Foundation
struct Patient{
    let name: String?
    let bloodType: String?
    let address: String?
    let time: String?
    let description: String?
    
    init(name: String, bloodType: String, address: String, time: String, description: String) {
        self.name = name
        self.bloodType = bloodType
        self.address = address
        self.time = time
        self.description = description
    }
    
}
