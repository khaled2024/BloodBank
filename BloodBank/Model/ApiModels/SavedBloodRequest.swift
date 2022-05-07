//
//  SavedBloodRequest.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 07/05/2022.
//

import Foundation
struct SavedBloodRequest: Codable{
    var status: Int
    var data: [SavedBloodRequestData]
}
struct SavedBloodRequestData: Codable {
    var id: String
    var p_ssn: String
    var request_id: String
    var time: String
}
