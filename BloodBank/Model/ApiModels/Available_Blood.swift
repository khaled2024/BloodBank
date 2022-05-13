//
//  Available_Blood.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 12/05/2022.
//

//Available_Blood

import Foundation
struct AvailableBlood: Codable {
    let status: Int
    let data: [AvailableBloodData]
}
// MARK: - Datum
struct AvailableBloodData: Codable {
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
