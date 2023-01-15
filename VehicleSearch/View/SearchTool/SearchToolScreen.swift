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
    
    let searchFieldGroupContainer = UIStackView().apply {stack in
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
    
    
    let searchBtn = UIButton().apply{ btn in
        
        btn.setTitle("go".localized().uppercased(), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 24)
        btn.backgroundColor = UIColor(named: "Green")
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(onBackPressed))
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
        contentView.addSubview(searchFieldGroupContainer)
        
        searchFieldGroupContainer
            .addViewConstraints(
                leading: contentView.leadingAnchor,
                top: titleHeader.bottomAnchor,
                trailing: contentView.trailingAnchor,
                paddingTop:32,
                height: 56
            )
        
        initSearchViewPrefixView()
        
        let searchFieldContainer = UIView()
        searchFieldContainer.backgroundColor = UIColor(named: "White")
        searchFieldContainer.addSubview(searchInputField)
        
        
        searchInputField.addViewConstraints(
            leading: searchFieldContainer.leadingAnchor,
            top: searchFieldContainer.topAnchor,
            trailing: searchFieldContainer.trailingAnchor,
            bottom: searchFieldContainer.bottomAnchor,
            paddingStart: 12,paddingEnd: 12
        )
        
        searchFieldGroupContainer.addArrangedSubview(searchFieldContainer)
        
        
        let spacerView = UIView()
        searchFieldGroupContainer.addArrangedSubview(spacerView)
        spacerView.addViewConstraints(width: 12)
        
        
        
        searchFieldGroupContainer.addArrangedSubview(searchBtn)
        searchBtn.addViewConstraints(width:75)
        searchBtn.addTarget(self, action: #selector(onSearchBtnClick),for: .touchUpInside)
        
        
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
            top: searchFieldGroupContainer.bottomAnchor,
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
            top: searchFieldGroupContainer.bottomAnchor,
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
            top: searchFieldGroupContainer.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 32
        )
        
    }
    
    func getInfoRow(item:VehicleFeatureInfoModel) -> UIStackView{
        
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical 
        infoStack.spacing = 4
        
        
        let title = UILabel()
        title.text  = item.feature
        title.textColor = UIColor(named: "White")
        title.font = UIFont(name: "Roboto", size: 24)
        infoStack.addArrangedSubview(title)
        
        let data = UILabel()
        data.text  = item.status
        data.font = UIFont(name: "Roboto", size: 18)
        
        if item.highlighted{
            data.textColor =  UIColor(named: "Green")?.withAlphaComponent(0.8)
        }else{
            data.textColor =  UIColor(named: "White")?.withAlphaComponent(0.8)
            
        }
        
        infoStack.addArrangedSubview(data)
        
        
        return infoStack
    }
    
    
    
    let searchLeadingContent = {
        let v = UIStackView()
        v.distribution  = .equalSpacing
        v.alignment = .center
        v.axis = .vertical
        v.backgroundColor = UIColor(named: "Blue")
        return v
    }()
    
    func initSearchViewPrefixView(){
        
        searchFieldGroupContainer.addArrangedSubview(searchLeadingContent)
        
        searchLeadingContent.addViewConstraints(
            leading: searchFieldGroupContainer.leadingAnchor,
            top: searchFieldGroupContainer.topAnchor,
            bottom: searchFieldGroupContainer.bottomAnchor,
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
        view.endEditing(true)
        let text : String? = searchInputField.text
        
        if text==nil || text!.isEmpty{
            self.showToast(message: "empty_reg_no_msg".localized())
        }
        
        viewModel.queryVehicleInfo(query:text ?? "")
         
    }
     
    
    @objc func onBackPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

struct MainPreview : PreviewProvider{
    @available(iOS 13.0, *)
    static var previews: some View{
        UINavigationController(rootViewController: SearchToolScreen()).showPreview()
        
    }
}
