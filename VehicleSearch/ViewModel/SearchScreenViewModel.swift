//
//  SearchScreenViewModel.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Combine

import Foundation


final class SearchScreenViewModel{
    
    private(set) var state :Binder<UiState<[VehicleFeatureInfoModel]>> = Binder(UiState.idle)
    
    private let apiService = VehicleInfoFetchServiceImpl()
    
    
    var vehicleRegNo:String = ""{
        didSet{
            fetchDetails(regNo: vehicleRegNo)
        }
    }
    func queryVehicleInfo(query:String){
        self.vehicleRegNo = query
    }
    
    func fetchDetails(regNo:String) {
        if case .loading = state.value{
            return
        }
        if regNo.isEmpty {
            state.value = UiState.idle
            return
        }
        state.value = UiState.loading
        
        apiService.queryDetails(regNo: regNo){result in
            DispatchQueue.main.async {
                
                switch result.self{
                    
                case .content(let data):
                    var info:[VehicleFeatureInfoModel] = []
                    
                    info.append(VehicleFeatureInfoModel(feature: "Make", status: data.make))
                    
                    info.append(VehicleFeatureInfoModel(feature: "Model", status: data.model))
                    
                    info.append(VehicleFeatureInfoModel(feature: "Details", status: data.details))
                    
                    info.append(VehicleFeatureInfoModel(feature: "Body Type", status: data.bodyType))
                    
                    info.append(VehicleFeatureInfoModel(feature: "Engine", status: data.engine))
                    
                    info.append(VehicleFeatureInfoModel(feature: "Year", status: data.year))
                    
                    info.append(VehicleFeatureInfoModel(feature: "GearBox", status: data.gearbox))
                    
                    let date = self.parseDateStr(from: data.motExpiry)
                    info.append(VehicleFeatureInfoModel(feature: "MOT", status: "Valid until \(date)",highlighted : true))
                    
                    self.state.value = UiState.content(info)
                    
                    break
                    
                    
                case .error(let error):
                    self.state.value = UiState.error(error)
                    break
                }
            }
        }
        
        
    }
    
    func parseDateStr(from inputStr:String)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date =  formatter.date(from: inputStr) else{
            return "--"
        }
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
        
    }
    
    
}
