//
//  DonatePlaces.swift
//  BloodBank
//
//  Created by KhaleD HuSsien on 24/04/2022.
//

import Foundation

struct DonatePlaces: Codable {
    let status: Int
    let data: [placesData]
}
struct placesData: Codable {
    let id: String
    let place_name: String
    let place_manager: String
    let city_id: String
    let lat: String
    let lng: String
    let open_at: String
    let close_at: String
    let holiday: String
    let city_name: String
    let governorate_name: String
}
