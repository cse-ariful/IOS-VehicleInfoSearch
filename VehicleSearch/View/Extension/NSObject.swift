//
//  NSObject.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/14/23.
//

import Foundation

protocol HasApply {
    
}

extension HasApply {
    func apply(closure:(Self) -> ()) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: HasApply {}
