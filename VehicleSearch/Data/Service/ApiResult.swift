//
//  ApiResult.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/14/23.
//
import Foundation
enum ApiResult<UiState> {
    case content(UiState)
    case error(String)
    
}
