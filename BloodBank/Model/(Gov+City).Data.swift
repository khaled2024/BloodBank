//
//  (Gov+City).Data.swift
//  BloodBank
//  Created by KhaleD HuSsien on 26/04/2022.
//

import Foundation

class userGovernorate{
    var id: String!
    var name: String!
    var cities: [userCity]!
    
    init(id: String, name: String, cities: [userCity]) {
        self.id = id
        self.name = name
        self.cities = cities
    }
    
  
}
class userCity{
    var name: String!
    var governorateId: String!
    
    init(name: String, governoratedId: String){
        self.name = name
        self.governorateId = governoratedId
    }
    
   
}
