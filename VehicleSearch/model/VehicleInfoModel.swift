//
//  VehicleInfoModel.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Foundation

struct VehicleInfoModel : Codable{ 
    let make : String
    let model : String
    let details : String
    let engine : String
    let gearbox : String
    let bodyType : String
    let year : String
    let motExpiry : String
}
