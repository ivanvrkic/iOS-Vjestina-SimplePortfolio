//
//  PortfolioViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//

import Foundation
import UIKit
class PortfolioViewController: UIViewController{
    
    private var router:AppRouter!
    private var theme:ThemeProtocol!
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 30
    private var smallMargin:CGFloat = 20
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightSmall:CGFloat = 30
    private var heightBig:CGFloat = 50
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "PORTFOLIO VALUE"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private var labelAmount: UILabel = {
        let label = UILabel()
        label.text = "1000$"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    private var labelChangeAmount: UILabel = {
        let label = UILabel()
        label.text = "+200$"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private var labelChangePercent: UILabel = {
        let label = UILabel()
        label.text = "+5.00%"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private var changeView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    private var topView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var tableView: UITableView!
    
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
        topView.addArrangedSubview(labelTitle)
        topView.addArrangedSubview(labelAmount)
        changeView.addArrangedSubview(labelChangeAmount)
        changeView.addArrangedSubview(labelChangePercent)
        topView.addArrangedSubview(changeView)
        view.addSubview(topView)
        
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
        
        topView.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        topView.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        topView.autoPinEdge(toSuperviewEdge: .top, withInset: titleMargin)
        
    }
    
    private func styleViews(){
        view.backgroundColor = theme.backgroundColor
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [theme.greenColor.cgColor, theme.backgroundColor.cgColor]
        view.layer.insertSublayer(gradient, below: topView.layer)
        
        labelTitle.textColor = theme.fontColor
        labelAmount.textColor = theme.fontColor
        labelChangeAmount.textColor = theme.fontColor
        labelChangePercent.textColor = theme.fontColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    
}
