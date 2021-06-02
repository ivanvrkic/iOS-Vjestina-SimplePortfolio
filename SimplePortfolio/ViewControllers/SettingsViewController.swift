//
//  SettingsViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//

import Foundation
import Foundation
import UIKit
class SettingsViewController: UIViewController{
    
    private var router:AppRouter!
    private var theme:ThemeProtocol!
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 30
    private var smallMargin:CGFloat = 20
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightSmall:CGFloat = 30
    private var heightBig:CGFloat = 50
    
    private var labelThemeTitle: UILabel = {
        let label = UILabel()
        label.text = "Themes"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        return label
    }()
    
    private var labelTheme: UILabel = {
        let label = UILabel()
        label.text = "Dark mode"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        return label
    }()
    
    private var switchTheme: UISwitch = {
        let uiswitch = UISwitch()
        uiswitch.addTarget(self, action: #selector(changeTheme), for: .valueChanged)
        return uiswitch
    }()
    
    private var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var stackTheme: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    init(router: AppRouter){
        super.init(nibName: nil, bundle: nil)
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        theme = getCurrentTheme()
        styleViews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        stack.addArrangedSubview(labelThemeTitle)
        stack.addArrangedSubview(stackTheme)
        stackTheme.addArrangedSubview(labelTheme)
        stackTheme.addArrangedSubview(switchTheme)
        view.addSubview(stack)
        
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
        
        stack.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .top, withInset: titleMargin)
        
    }
    
    private func styleViews(){
        view.backgroundColor = theme.backgroundColor
        labelTheme.textColor = theme.fontColor
        labelThemeTitle.textColor = theme.fontColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    @objc private func changeTheme(){
        if (switchTheme.isOn){
            setTheme(themeKey: .dark)
        } else {
            setTheme(themeKey: .light)
        }
        theme = getCurrentTheme()
        styleViews()
    }
    
}
