//
//  VehicleInfoFetchService.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Foundation


class VehicleInfoFetchServiceImpl : VehicleSearchService {
    func queryDetails(regNo: String) async -> ApiResult<VehicleInfoModel> {
        do{
            guard let request = VehicleSearchApi.queryVehicleDetails(regNo: regNo)
                .request else {
                return ApiResult.error("Error creating url")
            }
            
            print(request)
            
            let (data,response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return ApiResult.error("Invalid Reg No")
            }
            
            print("decoding")
            let decoder = JSONDecoder()
            let decodedData  = try decoder.decode(VehicleInfoModel.self, from: data)
            print("data decoded")
            print(decodedData)
            return ApiResult.content(decodedData)
            
        }catch{
            return ApiResult.error("Something went wrong")
        }
    }
    
    
    
}
