//
//  SearchFieldComponent.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/16/23.
//

import Foundation
import UIKit

class SearchFieldContainerView : UIStackView{
    
    var onSearchActionHandler: ((String?) -> Void)?
    
    let searchLeadingContent = {
        let v = UIStackView()
        v.distribution  = .equalSpacing
        v.alignment = .center
        v.axis = .vertical
        v.backgroundColor = UIColor(named: "Blue")
        return v
    }()
    
    let searchInputField =  UITextField().apply{inputField in
        
        inputField.isEnabled  = true
        inputField.isUserInteractionEnabled = true
        inputField.attributedPlaceholder = NSAttributedString(
            string: "enter_reg".localized().uppercased(),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        inputField.font = UIFont(name: "Oswald-Regular", size: 24)
        inputField.borderStyle = UITextField.BorderStyle.none
        inputField.autocorrectionType = UITextAutocorrectionType.no
        inputField.autocapitalizationType = .none
        inputField.keyboardType = UIKeyboardType.default
        inputField.returnKeyType = UIReturnKeyType.done
        inputField.clearButtonMode = UITextField.ViewMode.whileEditing
        inputField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
    }
    let searchFieldContainer = UIView().apply{view in
        view.backgroundColor = UIColor(named: "White")
    }
    
    
    
    let searchBtn = UIButton().apply{ btn in
        
        btn.setTitle("go".localized().uppercased(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 24)
        btn.backgroundColor = UIColor(named: "Green")
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    func setSearchActionHandler(handler: ((String?) -> Void)? ){
        self.onSearchActionHandler = handler
    }
    
    func initialize() {
        
        addArrangedSubview(searchLeadingContent)
        searchFieldContainer.addSubview(searchInputField)
        addArrangedSubview(searchFieldContainer)
        
        addArrangedSubview(searchBtn)
        
        let spacerView = UIView()
        spacerView.addViewConstraints(width: 12)
        
        addArrangedSubview(spacerView)
        
        
        
        configureSearchLeadingIcon()
        
        searchInputField.addViewConstraints(
            leading:  searchFieldContainer.leadingAnchor,
            top:  searchFieldContainer.topAnchor,
            trailing:  searchFieldContainer.trailingAnchor,
            bottom:  searchFieldContainer.bottomAnchor,
            paddingStart: 12,paddingEnd: 12
        )
         
        searchBtn.addViewConstraints(width:75)
        
        searchBtn.addTarget(self, action: #selector(onSearchBtnClick),for: .touchUpInside)

    }
    
    func configureSearchLeadingIcon(){
        searchLeadingContent.addViewConstraints(
            leading:  leadingAnchor,
            top:  topAnchor,
            bottom:  bottomAnchor,
            width: 42
        )
        
        searchLeadingContent.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom:8, right: 0)
        searchLeadingContent.isLayoutMarginsRelativeArrangement = true
        
        let image = UIImageView(image: UIImage(named: "Flag")?.withRenderingMode(.alwaysOriginal))
        searchLeadingContent.addArrangedSubview(image)
        
        let label  = UILabel()
        label.text = "GB"
        label.font = UIFont(name: "Roboto-Bold", size: 16)
        label.textAlignment = .center
        label.textColor = UIColor(named: "Yellow")
        searchLeadingContent.addArrangedSubview(label)
        
    }
    
    @objc func onSearchBtnClick(){
        
        let text : String? = searchInputField.text
        
        if(onSearchActionHandler != nil){
            onSearchActionHandler!(text)
        }
        
         
    }
    
}
