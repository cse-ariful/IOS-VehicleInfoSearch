//
//  VehicleSearchScreen.swift
//  VehicleSearch
//
//  Created by Ariful Jannat Arif on 1/13/23.
//

import UIKit
import SwiftUI

class VehicleSearchScreen: UIViewController {
    
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
        title.text = "Search Tool".uppercased()
        title.textColor = UIColor(named: "Black")
        title.font = UIFont(name: "Roboto-Bold", size: 20)
        
    }
    
    let titleHeader  = UILabel().apply { label in
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What's your\nvehicle reg?".uppercased()
        label.font = UIFont(name: "Oswald-Regular", size: 36)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "White")
    }
    
    let searchInputField =  UITextField().apply{inputField in
        
        inputField.isEnabled  = true
        inputField.isUserInteractionEnabled = true
        inputField.attributedPlaceholder = NSAttributedString(
            string: "Enter Reg".uppercased(),
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
        
        btn.setTitle("GO", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 24)
        btn.backgroundColor = UIColor(named: "Green")
    }
    
    
    let resultView = UIStackView().apply{ stack in
        
        stack.backgroundColor = UIColor(named: "CardBackground")
        stack.spacing = 8
        stack.axis = .vertical
        
    }
    
    let loadingView = UIView().apply{v in
        v.backgroundColor = .yellow
        v.isHidden = true
    }
    
    let errorView = UIView().apply{v in
        v.backgroundColor = .red
        v.isHidden = true
    }
    
    let viewModel = SearchScreenViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Green")
        setupViews()
        setUpViewModel()
    }
    func setUpViewModel(){
        
        
    }
    
    func setupViews(){
        view.addSubview(rootView)
        rootView.addViewConstarint(start: view.leadingAnchor,
                                   top:  view.safeAreaLayoutGuide.topAnchor,
                                   end: view.trailingAnchor,
                                   bottom: view.bottomAnchor)
        rootView.addSubview(contentView)
        contentView.addViewConstarint(start: rootView.leadingAnchor,
                                      top: rootView.topAnchor,
                                      end: rootView.trailingAnchor,
                                      bottom: rootView.bottomAnchor,
                                      paddingStart: 20,paddingTop:20,paddingEnd: 20)
        setupToolbar()
        addHeaderTitle()
        addSearchContainer()
        addSearchResultView()
        addLoadingIndicatorView()
        addErrorView()
         
    }
    
    func setupToolbar(){
        navigationItem.titleView = toolbarTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .plain, target: self, action: #selector(onBackPressed))
        navigationController?.navigationBar.tintColor =  UIColor(named: "Black")
    }
    func addHeaderTitle(){
        contentView.addSubview(titleHeader)
        titleHeader.addViewConstarint(start: contentView.leadingAnchor,top: contentView.topAnchor,end: contentView.trailingAnchor, paddingTop: 24)
    }
    func addSearchContainer(){
        contentView.addSubview(searchFieldGroupContainer)
        
        searchFieldGroupContainer
            .addViewConstarint( start: contentView.leadingAnchor, top: titleHeader.bottomAnchor, end: contentView.trailingAnchor,  paddingTop:20, height: 56 )
        
        initSearchViewPrefixView()
        
        let searchFieldContainer = UIView()
        searchFieldContainer.backgroundColor = UIColor(named: "White")
        searchFieldContainer.addSubview(searchInputField)
        
        
        searchInputField.addViewConstarint(start: searchFieldContainer.leadingAnchor,
                                           top: searchFieldContainer.topAnchor,
                                           end: searchFieldContainer.trailingAnchor,
                                           bottom: searchFieldContainer.bottomAnchor,paddingStart: 12,paddingEnd: 12)
        
        
        
        searchBtn.addTarget(self, action: #selector(onSearchBtnClick), for: .touchUpInside)
        
        searchFieldGroupContainer.addArrangedSubview(searchFieldContainer)
        
        let spacerView = UIView()
        searchFieldGroupContainer.addArrangedSubview(spacerView)
        spacerView.addViewConstarint(width: 12)
        
        searchFieldGroupContainer.addArrangedSubview(searchBtn)
        
        
        searchBtn.addViewConstarint(width:75)
        
    }
    
    func addErrorView(){
        contentView.addSubview(errorView)
        errorView.addViewConstarint(start: contentView.leadingAnchor,top: searchFieldGroupContainer.bottomAnchor,end: contentView.trailingAnchor,paddingTop: 32,height: 150)
    }
    func addLoadingIndicatorView(){
        contentView.addSubview(loadingView)
        loadingView.addViewConstarint(start: contentView.leadingAnchor,top: searchFieldGroupContainer.bottomAnchor,end: contentView.trailingAnchor,paddingTop: 32,height: 150)
    }
    
    func addSearchResultView(){
        
        
        let greenBar = UIView()
        greenBar.heightAnchor.constraint(equalToConstant: 12).isActive = true
        greenBar.backgroundColor = UIColor(named: "Green")
        
        resultView.addArrangedSubview(greenBar)
        
        
        let dataList = UIStackView()
        dataList.axis = .vertical
        dataList.spacing = 24
        resultView.addArrangedSubview(dataList)
        
        
        dataList.layoutMargins = UIEdgeInsets(top: 12, left: 20, bottom: 20, right: 20)
        dataList.isLayoutMarginsRelativeArrangement = true
        
        var info:[FeatureInfoModel] = []
        info.append(FeatureInfoModel(feature: "Make", status: "KIA"))
        info.append(FeatureInfoModel(feature: "Model", status: "Picanto"))
        info.append(FeatureInfoModel(feature: "Details", status:"1.25 GT-line 5dr"))
        info.append(FeatureInfoModel(feature: "Body Type", status: "Hatchback"))
        info.append(FeatureInfoModel(feature: "Engine", status: "1.25L"))
        info.append(FeatureInfoModel(feature: "Year", status: "2017"))
        info.append(FeatureInfoModel(feature: "GearBox", status: "Manual"))
        info.append(FeatureInfoModel(feature: "MOT", status: "Valid until 18-09-2023"))
        var r:[UIStackView] = []
        for item in info{
            let info = getInfoRow(titleText: item.feature, value: item.status, valueTextColor: UIColor(named: "White"))
            r.append(info)
            if r.count == 2 {
                dataList.addArrangedSubview(getNewRowStack(col1: r.remove(at: 0), col2: r.remove(at: 0)))
            }
        }
        contentView.addSubview(resultView)
        resultView.addViewConstarint(start: contentView.leadingAnchor,top: searchFieldGroupContainer.bottomAnchor,end: contentView.trailingAnchor,paddingTop: 32)
        
    }
    func getNewRowStack(col1:UIView, col2:UIView) -> UIStackView{
        let rowStack =  UIStackView()
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.addArrangedSubview(col1)
        rowStack.addArrangedSubview(col2)
        return rowStack
    }
    
    func getInfoRow(titleText:String,value:String,valueTextColor:UIColor?) -> UIStackView{
        
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.addViewConstarint(height: 65)
        
        
        let title = UILabel()
        title.text  = titleText
        title.textColor = UIColor(named: "White")
        title.font = UIFont(name: "Roboto", size: 24)
        infoStack.addArrangedSubview(title)
        
        let data = UILabel()
        data.text  = value
        data.textColor = valueTextColor
        data.font = UIFont(name: "Roboto-Light", size:18)
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
        
        searchLeadingContent.addViewConstarint(start: searchFieldGroupContainer.leadingAnchor,top: searchFieldGroupContainer.topAnchor,  bottom: searchFieldGroupContainer.bottomAnchor, width: 42)
        
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
        if let query = text{
            viewModel.queryVehicleInfo(query:query)
        }
    }
    
    
    
    @objc func gotoSearchScreen(){
        //        let nextScreen = VehicleSearchScreen()
        //        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func onBackPressed(){
        navigationController?.popViewController(animated: true)
    }
    
}

struct MainPreview : PreviewProvider{
    static var previews: some View{
        UINavigationController(rootViewController: VehicleSearchScreen()).showPreview()
        
    }
}
