//
//  UiState.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Foundation
enum UiState<UiState> {
    
    case idle
    case loading
    case content(UiState)
    case error(String)
    
}
