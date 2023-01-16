//
//  UIViewExtension.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/13/23.
//

import Foundation
import UIKit
import SwiftUI

extension UIView {
    func addViewConstraints(leading: NSLayoutXAxisAnchor?=nil,top: NSLayoutYAxisAnchor?=nil, trailing: NSLayoutXAxisAnchor?=nil,  bottom: NSLayoutYAxisAnchor?=nil, paddingStart: CGFloat=0, paddingTop: CGFloat=0, paddingEnd: CGFloat=0,  paddingBottom: CGFloat=0,width: CGFloat=0, height: CGFloat=0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingStart).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -paddingEnd).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
