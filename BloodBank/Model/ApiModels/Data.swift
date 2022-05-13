//
//  Data.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/05/2022.
//

import Foundation


// MARK: - DataModel
struct myData: Codable {
    let status: Int
    let msg: [x]
}

// MARK: - Msg
struct x: Codable {
    let id, bloodTypeID, placeID, amount: String
    let price, time, adminSsn: String

    enum CodingKeys: String, CodingKey {
        case id
        case bloodTypeID = "blood_type_id"
        case placeID = "place_id"
        case amount, price, time
        case adminSsn = "admin_ssn"
    }
}
//MARK: - oneData
struct oneData: Codable {
    let status: Int
    let msg: y
}

// MARK: - Msg
struct y: Codable {
    let id, bloodTypeID, placeID, amount: String
    let price, time, adminSsn: String

    enum CodingKeys: String, CodingKey {
        case id
        case bloodTypeID = "blood_type_id"
        case placeID = "place_id"
        case amount, price, time
        case adminSsn = "admin_ssn"
    }
}

