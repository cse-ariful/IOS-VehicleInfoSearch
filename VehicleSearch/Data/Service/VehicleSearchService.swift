//
//  VehicleSearchService.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/14/23.
//

import Foundation
protocol VehicleSearchService {
    func queryDetails(regNo:String,completion:@escaping  (ApiResult<VehicleInfoModel>)->()) 
}
