//
//  VehicleInfoFetchService.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Foundation


class VehicleInfoFetchServiceImpl : VehicleSearchService {
       
    
    func queryDetails(regNo: String, completion: @escaping  (ApiResult<VehicleInfoModel>) -> ()) {
        
        guard let request = VehicleSearchApi.queryVehicleDetails(regNo: regNo).request else {
            completion( ApiResult.error("Error creating url"))
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(ApiResult.error("Invalid Reg No"))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedData  = try decoder.decode(VehicleInfoModel.self, from: data!)
                completion(ApiResult.content(decodedData))
            }catch{
                completion(ApiResult.error("Something went wrong"))
            }
            
            
        }).resume()
    }
}
