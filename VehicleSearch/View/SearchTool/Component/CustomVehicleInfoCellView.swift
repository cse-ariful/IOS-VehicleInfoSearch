//
//  CustomVehicleInfoCellView.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/15/23.
//

import Foundation
import UIKit

class CustomVehicleInfoCellView : UICollectionViewCell{
    static let identifier = "CustomCollectionViewCell"
    let title = UILabel().apply{label in
        label.textColor = UIColor(named: "White")?.withAlphaComponent(0.9)
        label.font = UIFont(name: "Roboto-Medium", size: 20)
    }
    let subtitle = UILabel().apply{label in
        label.font = UIFont(name: "Roboto-Medium", size: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    func setItem(item:VehicleFeatureInfoModel){
        title.text  = item.feature.uppercased()
        subtitle.text  = item.status
        if item.highlighted{
            subtitle.textColor =  UIColor(named: "Green")?.withAlphaComponent(0.7)
        }else{
            subtitle.textColor =  UIColor(named: "White")?.withAlphaComponent(0.7)
            
        }
    }
 
    func initialize() {
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.addArrangedSubview(title)
        infoStack.addArrangedSubview(subtitle)
        addSubview(infoStack)
        infoStack.addViewConstraints(leading: leadingAnchor,top: topAnchor,trailing: trailingAnchor,bottom: bottomAnchor,paddingTop: 12)
    }
}
