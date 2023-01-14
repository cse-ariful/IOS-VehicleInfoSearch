//
//  SearchScreenViewModel.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Combine

import Foundation


final class SearchScreenViewModel{
    
    @Published private(set) var state : UiState<[VehicleFeatureInfoModel]> = UiState.idle
    
    //    var state = BehaviorRelay<VehicleInfoModel?>(nil)
    private let apiService = VehicleInfoFetchServiceImpl()
    
    
    var vehicleRegNo:String = ""{
        didSet{
            Task.init{
                await fetchDetails(regNo: vehicleRegNo)
            }
        }
    }
    func queryVehicleInfo(query:String){
        self.vehicleRegNo = query
    }
    
    func fetchDetails(regNo:String)async{
        if case .loading = state{
            return
        }
        state = UiState.loading
        
        print("loading started")
        let result = await apiService.queryDetails(regNo: regNo)
        print("loading finished \(result)")
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
                info.append(VehicleFeatureInfoModel(feature: "MOT", status: data.motExpiry,highlighted : true))
                    self.state = UiState.content(info)
                    break
                case .error(let error):
                    self.state = UiState.error(error)
                    break
            }
        }
        
        
    }
    
    
}
