//
//  Vaccine.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/04/2022.
//

import Foundation
struct Vaccine:Codable{
    var status: Int
    var data: [VaccineData]
}
struct VaccineData:Codable{
    var id: String
    var vaccine_id: String
    var country_id: String
    var vaccine_place_id: String
    var amount: String
    var price: String
    var admin_ssn: String
    var scientific_name: String
    var trade_name: String
    var country_name: String
    var hospital_name: String
}
