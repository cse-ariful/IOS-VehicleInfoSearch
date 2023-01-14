
import UIKit

class OnBoardingScreen: UIViewController {
    
    let contentStack  = UIStackView().apply {stack in
        stack.axis = .vertical
        stack.spacing = 32
    }
    
    let toolbarTitle = UILabel().apply{title in
        title.textColor = .white
        title.text = "New Feature".uppercased()
        title.textColor = UIColor(named: "Black") 
        title.font = UIFont(name: "Roboto-Bold", size: 20)
        title.textAlignment = .center
    }
    let titleHeader  =  UILabel().apply{ label in
        label.text = "Making Cars Easy".uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "White")
        
    }
    let titleMessage = UILabel().apply {label in
        label.text = "We've got a brilliant new vehicle\nsearch feature.. why not give it a try!"
        label.font = UIFont(name: "Roboto", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor(named: "White")
        label.translatesAutoresizingMaskIntoConstraints = false
        
    }
    let tryBtn = UIButton().apply{btn in
        btn.setTitle("Try it out".uppercased(), for: .normal)
        btn.setTitleColor(UIColor(named: "Black"), for: .normal)
        btn.backgroundColor = UIColor(named: "Green")
        btn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    let mainView = UIStackView().apply{v in
        v.backgroundColor =  UIColor(named: "Dark Gray")
    }
    
    let statusBarBg = UIView().apply { v in
        v.backgroundColor = UIColor(named: "Green")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    func setupViews(){
        view.addSubview(statusBarBg)
        statusBarBg.addViewConstarint(start: view.leadingAnchor ,top: view.topAnchor,end:view.trailingAnchor,bottom:  view.safeAreaLayoutGuide.topAnchor)
        view.addSubview(mainView)
        mainView.addViewConstarint(start: view.leadingAnchor,
                                   top:  view.safeAreaLayoutGuide.topAnchor,
                                   end: view.trailingAnchor,
                                   bottom: view.bottomAnchor)
        mainView.addSubview(contentStack)
        setupToolbar()
        setupContents()
        
    }
    func setupContents(){
        contentStack.addViewConstarint(start: view.leadingAnchor,top: view.readableContentGuide.topAnchor,end: view.trailingAnchor,paddingStart: 20,paddingTop:32,paddingEnd: 20)
        
        contentStack.addArrangedSubview(titleHeader)
        contentStack.addArrangedSubview(titleMessage)
        contentStack.addArrangedSubview(tryBtn)
        setupNextButton()
    }
    
    
    func setupToolbar(){
        navigationItem.titleView = toolbarTitle
        navigationController?.navigationBar.backgroundColor  = UIColor(named:"Green")
    }
    
    func setupNextButton(){
        tryBtn.addTarget(self, action: #selector(gotoSearchScreen), for: .touchUpInside)
        tryBtn.addViewConstarint(height: 48)
    }
    @objc func gotoSearchScreen(){
        let nextScreen = VehicleSearchScreen()
        navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    @objc func onBackPressed(){
        
    }
    
}
