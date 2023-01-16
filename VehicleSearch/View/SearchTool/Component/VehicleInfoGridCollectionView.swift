//
//  VehicleInfoGridCollectionView.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/15/23.
//

import Foundation
import UIKit

class VehicleInfoGridCollectionView : UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource   {
    
    var data:[VehicleFeatureInfoModel] = []
    
    let collectionViwLayout = UICollectionViewFlowLayout().apply{layutV in
        layutV.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        layutV.scrollDirection = .vertical
    }
    
    var collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("StoryBoard Is not used")
    }
    
    
    func setItem(items:[VehicleFeatureInfoModel]) {
        
        data = items
        collectionView.reloadData()
        
        collectionView.heightAnchor.constraint(equalToConstant: collectionView.collectionViewLayout.collectionViewContentSize.height).isActive = true
        collectionViwLayout.invalidateLayout()
    }
    
    
    func initialize(){
        
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: collectionViwLayout)
        self.collectionView.backgroundColor =  UIColor(named: "CardBackground")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionView.register(CustomVehicleInfoCellView.self, forCellWithReuseIdentifier: CustomVehicleInfoCellView.identifier)
        
        addSubview(collectionView)
        collectionView.addViewConstraints(
            leading: leadingAnchor,
            top: topAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width/2 - 32, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomVehicleInfoCellView.identifier, for: indexPath) as! CustomVehicleInfoCellView
        
        cell.setItem(item: data[indexPath.item])
        
        return cell
    }
    
}
