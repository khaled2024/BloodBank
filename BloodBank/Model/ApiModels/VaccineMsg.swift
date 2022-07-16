//
//  VaccineMsg.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 16/07/2022.
//

import Foundation
struct VaccineMsg: Codable{
    let status: Int
    let msg: [Msg]
}
struct Msg: Codable{
    let admin_ssn , amount , country_id , id , price , time , vaccine_id , vaccine_place_id : String
}
