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
    
    
    let resultView = UIStackView().apply{ stack in
        
        stack.backgroundColor = UIColor(named: "CardBackground")
        stack.spacing = 8
        stack.axis = .vertical
        
    }
    
    let loadingView = UIView().apply{v in
        v.backgroundColor = .yellow
        v.isHidden = true
    }
    
    let errorMessageLabel = UILabel().apply{ lbl in
        
        lbl.text = "Uh-oh! We couldn't find a vehicle with that registration.\n\n\nTry searching 'XXYYZZZ'..."
        lbl.textColor = UIColor(named: "White")
        lbl.numberOfLines  = 0
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Roboto", size: 18)
        
    }
    
    let errorView = UIView().apply{v in
        v.backgroundColor = UIColor(named: "CardBackground")
        v.isHidden = true
    }
    
    let viewModel = SearchScreenViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpViewModel()
    }
    
    func setUpViewModel(){
        
        
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
        statusBarBg.addViewConstarint(
            start: view.leadingAnchor ,
            top: view.topAnchor,
            end:view.trailingAnchor,
            bottom:  view.safeAreaLayoutGuide.topAnchor)
        
        view.addSubview(rootView)
        rootView.addViewConstarint(
            start: view.leadingAnchor,
            top:  view.safeAreaLayoutGuide.topAnchor,
            end: view.trailingAnchor,
            bottom: view.bottomAnchor
        )
        rootView.addSubview(contentView)
        contentView.addViewConstarint(
            start: rootView.leadingAnchor,
            top: rootView.topAnchor,
            end: rootView.trailingAnchor,
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
        titleHeader.addViewConstarint(
            start: contentView.leadingAnchor,
            top: contentView.topAnchor,
            end: contentView.trailingAnchor,
            paddingTop: 24
        )
    }
    
    func addSearchContainer(){
        contentView.addSubview(searchFieldGroupContainer)
        
        searchFieldGroupContainer
            .addViewConstarint(
                start: contentView.leadingAnchor,
                top: titleHeader.bottomAnchor,
                end: contentView.trailingAnchor,
                paddingTop:32,
                height: 56
            )
        
        initSearchViewPrefixView()
        
        let searchFieldContainer = UIView()
        searchFieldContainer.backgroundColor = UIColor(named: "White")
        searchFieldContainer.addSubview(searchInputField)
        
        
        searchInputField.addViewConstarint(
            start: searchFieldContainer.leadingAnchor,
            top: searchFieldContainer.topAnchor,
            end: searchFieldContainer.trailingAnchor,
            bottom: searchFieldContainer.bottomAnchor,
            paddingStart: 12,paddingEnd: 12
        )
        
        searchFieldGroupContainer.addArrangedSubview(searchFieldContainer)
        
        
        let spacerView = UIView()
        searchFieldGroupContainer.addArrangedSubview(spacerView)
        spacerView.addViewConstarint(width: 12)
        
        
        
        searchFieldGroupContainer.addArrangedSubview(searchBtn)
        searchBtn.addViewConstarint(width:75)
        searchBtn.addTarget(self, action: #selector(onSearchBtnClick),for: .touchUpInside)
        
        
    }
    
    func addErrorView(){
        contentView.addSubview(errorView)
        errorView.addSubview(errorMessageLabel)
        errorMessageLabel.addViewConstarint(
            start: errorView.leadingAnchor,
            top: errorView.topAnchor,
            end: errorView.trailingAnchor,
            bottom: errorView.bottomAnchor,
            paddingStart: 16,
            paddingEnd: 16
        )
        errorView.addViewConstarint(
            start: contentView.leadingAnchor,
            top: searchFieldGroupContainer.bottomAnchor,
            end: contentView.trailingAnchor,
            paddingTop: 32,
            height: 150
        )
    }
    func addLoadingIndicatorView(){
        contentView.addSubview(loadingView)
        loadingView.addViewConstarint(
            start: contentView.leadingAnchor,
            top: searchFieldGroupContainer.bottomAnchor,
            end: contentView.trailingAnchor,
            paddingTop: 42,
            height: 200
        )
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
        
        var info:[VehicleFeatureInfoModel] = []
        info.append(VehicleFeatureInfoModel(feature: "Make", status: "KIA"))
        info.append(VehicleFeatureInfoModel(feature: "Model", status: "Picanto"))
        info.append(VehicleFeatureInfoModel(feature: "Details", status:"1.25 GT-line 5dr"))
        info.append(VehicleFeatureInfoModel(feature: "Body Type", status: "Hatchback"))
        info.append(VehicleFeatureInfoModel(feature: "Engine", status: "1.25L"))
        info.append(VehicleFeatureInfoModel(feature: "Year", status: "2017"))
        info.append(VehicleFeatureInfoModel(feature: "GearBox", status: "Manual"))
        info.append(VehicleFeatureInfoModel(feature: "MOT", status: "Valid until 18-09-2023",highlighted: true))
        var r:[UIStackView] = []
        for item in info{
            let info = getInfoRow(item:item)
            r.append(info)
            if r.count == 2 {
                dataList.addArrangedSubview(getNewRowStack(col1: r.remove(at: 0), col2: r.remove(at: 0)))
            }
        }
        contentView.addSubview(resultView)
        resultView.addViewConstarint(
            start: contentView.leadingAnchor,
            top: searchFieldGroupContainer.bottomAnchor,
            end: contentView.trailingAnchor,
            paddingTop: 32
        )
        
    }
    func getNewRowStack(col1:UIView, col2:UIView) -> UIStackView{
        let rowStack =  UIStackView()
        rowStack.axis = .horizontal
        rowStack.distribution = .fillEqually
        rowStack.addArrangedSubview(col1)
        rowStack.addArrangedSubview(col2)
        return rowStack
    }
    
    func getInfoRow(item:VehicleFeatureInfoModel) -> UIStackView{
        
        
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.addViewConstarint(height: 65)
        
        
        let title = UILabel()
        title.text  = item.feature
        title.textColor = UIColor(named: "White")
        title.font = UIFont(name: "Roboto", size: 24)
        infoStack.addArrangedSubview(title)
        
        let data = UILabel()
        data.text  = item.status
        data.textColor = UIColor(named: item.highlighted ? "Green" : "White" )
        data.font = UIFont(name: "Roboto", size: 18)
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
        
        searchLeadingContent.addViewConstarint(
            start: searchFieldGroupContainer.leadingAnchor,
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
