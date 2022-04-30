//
//  AvailableVaccines.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 29/04/2022.
//

import Foundation
struct AvailableVaccines:Codable{
    var status: Int
    var data: [AvailableVaccineData]
}
struct AvailableVaccineData:Codable{
    var id: String
    var vaccine_id: String
    var country_id: String
    var vaccine_place_id: String
    var amount: String
    var price: String
    var time: String
    var admin_ssn: String
    
}
