//
//  VehicleSearchScreen.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/13/23.
//

import UIKit
import SwiftUI

class SearchToolScreen: UIViewController {
    
    let rootView = UIStackView().apply{v in
        v.backgroundColor =  UIColor(named: "Dark Gray")
    }
    
    let contentView = UIView()
    
    let statusBarBg = UIView().apply{v in
        v.backgroundColor = UIColor(named: "Green")
    }
    
    let searchFieldView = SearchFieldContainerView().apply {stack in
        stack.distribution = .fillProportionally
    }
    
    let toolbarTitle = UILabel().apply{title in
        
        title.textColor = .white
        title.text = "search_tool".localized().uppercased()
        title.textColor = UIColor(named: "Black")
        title.font = UIFont(name: "Roboto-Bold", size: 20)
        
    }
    
    let titleHeader  = UILabel().apply { label in
        
        let  str = NSMutableAttributedString()
            .appendWith(color: UIColor(named: "White")!, "search_tool_header".localized().uppercased())
            .appendWith(color: UIColor(named: "Green")!, weight: .bold, "?")
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = str
        label.font = UIFont(name: "Oswald-Regular", size: 36)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
    }
     
    let resultGridView = VehicleInfoGridCollectionView()
    
    let resultView = UIStackView().apply{ stack in
        stack.accessibilityIdentifier = "result_view" 
        stack.backgroundColor = UIColor(named: "CardBackground")
        stack.spacing = 8
        stack.axis = .vertical
        
    }
    
    let loadingIndicator = UIActivityIndicatorView().apply{iv in
        iv.color = UIColor(named: "Green")
        iv.tag =  12
        iv.startAnimating()
        
    }
    
    let loadingView = UIView().apply{v in
        v.accessibilityIdentifier = "loading_view"
        v.isHidden = true
    }
    
    let errorMessageLabel = UILabel().apply{ lbl in
        lbl.accessibilityIdentifier = "error_view"
        lbl.text = "invalid_reg_no".localized()
        lbl.textColor = UIColor(named: "White")
        lbl.numberOfLines  = 0
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Roboto", size: 18)
        
    }
    
    let errorView = UIView().apply{v in
        v.isHidden = true
    }
    
    let viewModel = SearchScreenViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpViewModel()
    }
    
    func setUpViewModel(){
        viewModel.state.bind{[weak self]  state in
            self?.onUiStateUpdated(state: state)
        }
        
    }
    
    func onUiStateUpdated(state : UiState<[VehicleFeatureInfoModel]>){
        
        resultView.isHidden = true
        errorView.isHidden = true
        loadingView.isHidden = true
        
        switch state{
        case .idle:
            break
        case .loading:
            loadingView.isHidden = false
            break
        case .content(let data):
            resultView.isHidden = false
            resultGridView.setItem(items: data)
            break
        case .error(_):
            errorView.isHidden = false
            break
        }
    }
 
    func setupViews(){
        initRootViews()
        setupToolbar()
        addHeaderTitle()
        addSearchContainer()
        addSearchResultView()
        addLoadingIndicatorView()
        addErrorView()
    }
    
    func initRootViews() {
        view.addSubview(statusBarBg)
        statusBarBg.addViewConstraints(
            leading: view.leadingAnchor ,
            top: view.topAnchor,
            trailing:view.trailingAnchor,
            bottom:  view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(rootView)
        rootView.addViewConstraints(
            leading: view.leadingAnchor,
            top:  view.safeAreaLayoutGuide.topAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        rootView.addSubview(contentView)
        contentView.addViewConstraints(
            leading: rootView.leadingAnchor,
            top: rootView.topAnchor,
            trailing: rootView.trailingAnchor,
            bottom: rootView.bottomAnchor,
            paddingStart: 20,paddingTop:20,paddingEnd: 20
        )
    }
    
    func setupToolbar(){
        navigationItem.titleView = toolbarTitle
        let backImageIcon =  UIImage(named: "Back")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImageIcon, style: .plain, target: self, action: #selector(onBackPressed))
        navigationController?.navigationBar.tintColor =  UIColor(named: "Black")
    }
    
    func addHeaderTitle(){
        contentView.addSubview(titleHeader)
        titleHeader.addViewConstraints(
            leading: contentView.leadingAnchor,
            top: contentView.topAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 24
        )
    }
    
    func addSearchContainer(){
        contentView.addSubview(searchFieldView)
        
        searchFieldView
            .addViewConstraints(
                leading: contentView.leadingAnchor,
                top: titleHeader.bottomAnchor,
                trailing: contentView.trailingAnchor,
                paddingTop:32,
                height: 50
            )
        
        searchFieldView.setSearchActionHandler{text in
            self.onSearchBtnClick(text: text)
        }
    }
    
    func addErrorView(){
        contentView.addSubview(errorView)
        errorView.addSubview(errorMessageLabel)
        errorMessageLabel.addViewConstraints(
            leading: errorView.leadingAnchor,
            top: errorView.topAnchor,
            trailing: errorView.trailingAnchor,
            bottom: errorView.bottomAnchor,
            paddingStart: 16,
            paddingEnd: 16
        )
        errorView.addViewConstraints(
            leading: contentView.leadingAnchor,
            top: searchFieldView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 32,
            height: 150
        )
    }
    
    func addLoadingIndicatorView(){
        contentView.addSubview(loadingView)
        loadingView.addSubview(loadingIndicator)
        
        loadingView.addViewConstraints(
            leading: contentView.leadingAnchor,
            top: searchFieldView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 42,
            height: 200
        )
        
        loadingIndicator.addViewConstraints(
            leading: loadingView.centerXAnchor,
            top: loadingView.centerYAnchor,
            trailing: loadingView.centerXAnchor,
            bottom: loadingView.centerYAnchor
        )
        
    }
    
    func addSearchResultView(){
        
        let greenBar = UIView()
        greenBar.addViewConstraints(height: 12)
        greenBar.backgroundColor = UIColor(named: "Green")
        
        resultView.addArrangedSubview(greenBar) 
        resultView.addArrangedSubview(resultGridView) 
         
        contentView.addSubview(resultView)
        resultView.addViewConstraints(
            leading: contentView.leadingAnchor,
            top: searchFieldView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 32
        )
        
    }
    
    func onSearchBtnClick(text:String?){
        view.endEditing(true)
        
        if text==nil || text!.isEmpty{
            self.showToast(message: "empty_reg_no_msg".localized())
        }
        
        viewModel.queryVehicleInfo(query:text ?? "")
    }
     
    @objc func onBackPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

