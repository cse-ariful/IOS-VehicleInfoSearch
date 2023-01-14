//
//  SearchScreenViewModel.swift
//  VehicleInfo
//
//  Created by Ariful Jannat Arif on 1/11/23.
//

import Combine

import Foundation

struct FeatureInfoModel{
    let feature : String
    let status : String
}

final class SearchScreenViewModel{
    
    @Published private(set) var state : UiState<[FeatureInfoModel]> = UiState.idle
    
    //    var state = BehaviorRelay<VehicleInfoModel?>(nil)
    
    
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
        
        do{
            guard let request = VehicleSearchApi.queryVehicleDetails(regNo: regNo)
                .request else {
                notifyError()
                return
            }
            
            print(request)
            
            let (data,response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                notifyError()
                return
            }
            
            print("decoding")
            let decoder = JSONDecoder()
            let decodedData  = try decoder.decode(VehicleInfoModel.self, from: data)
            print("data decoded")
            print(decodedData)
            DispatchQueue.main.async {
                var info:[FeatureInfoModel] = []
                info.append(FeatureInfoModel(feature: "Make", status: decodedData.make))
                info.append(FeatureInfoModel(feature: "Model", status: decodedData.model))
                info.append(FeatureInfoModel(feature: "Details", status: decodedData.details))
                info.append(FeatureInfoModel(feature: "Body Type", status: decodedData.bodyType))
                info.append(FeatureInfoModel(feature: "Engine", status: decodedData.engine))
                info.append(FeatureInfoModel(feature: "Year", status: decodedData.year))
                info.append(FeatureInfoModel(feature: "GearBox", status: decodedData.gearbox))
                info.append(FeatureInfoModel(feature: "MOT", status: decodedData.motExpiry))
                self.state = UiState.content(info)
            }
            
        }catch{
            notifyError()
        }
    }
    func notifyError(){
        print("error fetching")
        DispatchQueue.main.async {
            self.state = UiState.error("Something went wrong")
            
        }
    }
    
}
