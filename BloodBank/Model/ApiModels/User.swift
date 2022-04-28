//
//  UserData.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 25/04/2022.
//

import Foundation
struct User: Codable {
    let status: Int
    let data: [userData]
}
struct userData: Codable {
    let p_ssn: String
    let p_first_name: String
    let p_last_name: String
    let email: String
    let mobile_phone: String
    let home_phone: String
    let password: String
    let blood_type: String
    let birthday: String
    let gender_id: String
    let img: String
    let time: String
    let city_id: String
    let gender: String
    let city_name: String
    let governorate_name: String
}
