//
//  String.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/14/23.
//

import Foundation
import UIKit
extension String{
    func localized()->String{
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}


extension NSMutableAttributedString {

    @discardableResult func appendWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString{
        let attrText = NSAttributedString.makeWith(color: color, weight: weight, ofSize:ofSize, text)
        self.append(attrText)
        return self
    }

}
extension NSAttributedString {

    public static func makeWith(color: UIColor = UIColor.darkText, weight: UIFont.Weight = .regular, ofSize: CGFloat = 12.0, _ text: String) -> NSMutableAttributedString {

        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: ofSize, weight: weight), NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes:attrs)
    }
}
