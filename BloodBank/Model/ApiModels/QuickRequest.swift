//
//  QuickRequest.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 28/04/2022.
//

import Foundation
struct QuickRequest:Codable{
    var status: Int
    var data: [QuickRequestData]
}
struct QuickRequestData:Codable{
    var id: String
    var place_id: String
    var blood_bags_number: String
    var blood_type: String
    var request_type: String
    var donate_reason: String
    var message: String
    var time: String
    var p_ssn: String
    var hospital_name: String
    var city_of_hospital: String
    var first_name: String
    var last_name: String
    var patient_phone: String
    var patient_image: String
    var governorate_name: String
    var blood_request_type: String
}
