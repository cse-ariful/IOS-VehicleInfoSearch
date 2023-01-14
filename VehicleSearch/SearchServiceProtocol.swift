//
//  SearchServiceProtocol.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/14/23.
//

import Foundation
protocol SearchVehicleService{
    func getVehicleInfo(regNo:String) -> VehicleInfoModel?
}
