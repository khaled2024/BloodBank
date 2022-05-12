//
//  Blood_info.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/05/2022.
//

import Foundation
struct Blood_info: Codable{
    var status: Int
    var data: [Blood_info_Data]
}
struct Blood_info_Data: Codable {
    var blood_type_id: String
    var hospital_id: String
    var blood_type: String
    var hospital_name: String
    var amount: String
    var price: String
}
