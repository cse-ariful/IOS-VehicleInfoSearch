//
//  PexelsApi.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 11/1/23.
//

import Foundation

private var apiKey = "PMAK-63874d1a7712610787f20c37-3d5715ea89d3a0be8075394ab35426cad5"

enum VehicleSearchApi{
    case queryVehicleDetails(regNo:String)
    
}


extension VehicleSearchApi{
    var host:String  {"da4705d6-9b2b-4f2a-8f19-6db21183fd13.mock.pstmn.io"}
    var path:String{
        switch self{
        case .queryVehicleDetails( _):
            return "/vehicle"
        }
    }
    
     
    var queryItems : [ String : String]? {
        switch self{
        case .queryVehicleDetails(let regNo):
            return ["registration":"\(regNo)"]
        }
    }
}
extension VehicleSearchApi{
    
    private var url:URL?{
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = host
        urlComponent.path = path
        urlComponent.queryItems = queryItems?.compactMap{item in
            URLQueryItem(name: item.key, value: item.value)
        }
        return urlComponent.url
    }
    var request : URLRequest?{
        guard let reqUrl = url  else {return nil}
        var urlReq = URLRequest(url: reqUrl)
        urlReq.cachePolicy = .returnCacheDataElseLoad //.reloadIgnoringLocalAndRemoteCacheData
        urlReq.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        urlReq.httpMethod = "GET"
        return urlReq
    }
}
