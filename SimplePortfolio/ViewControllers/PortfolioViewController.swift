//
//  PortfolioViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//


import Foundation
import UIKit
class PortfolioViewController: UIViewController,UITableViewDelegate{
    
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
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.register(PortfolioCellView.self, forCellReuseIdentifier: "PortfolioCell")
        view.rowHeight = 90
        return view
    }()
    
    private var presenter:Presenter!
    private var instruments:[Stock]!
    private var status:Status!
    
    init(router: AppRouter){
        super.init(nibName: nil, bundle: nil)
        self.router = router
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter = router.getPresenter()
        instruments = presenter.fetchForPortfolio()
        theme = getCurrentTheme()
        styleViews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
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
        
        view.addSubview(tableView)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        tableView.autoPinEdge(.top, to: .bottom, of: topView,withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        
        presenter = router.getPresenter()
        status = presenter.fetchStatus()
        labelAmount.text = String(status.valueOfPortfolio)+"$"
        labelChangeAmount.text = String(status.changeInCurrency)+"$"
        labelChangePercent.text = String(status.changeInPercentage)+"%"
    }
    
    private func styleViews(){
        view.backgroundColor = theme.backgroundColor
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        if(status.changeInPercentage > 0){
            gradient.colors = [theme.greenColor.cgColor, theme.backgroundColor.cgColor]
        } else {
            gradient.colors = [theme.redColor.cgColor, theme.backgroundColor.cgColor]
        }
        
        view.layer.insertSublayer(gradient, below: topView.layer)
        
        labelTitle.textColor = theme.fontColor
        labelAmount.textColor = theme.fontColor
        labelChangeAmount.textColor = theme.fontColor
        labelChangePercent.textColor = theme.fontColor
        
        tableView.backgroundColor = theme.backgroundColorSecond
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    
}

extension PortfolioViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instruments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:PortfolioCellView!
        cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath as IndexPath) as? PortfolioCellView
        
        cell.labelName.text = instruments[indexPath.row].name
        cell.labelSymbol.text = instruments[indexPath.row].symbol
//        cell.labelPrice.text = String(instruments[indexPath.row].price)+"$"
//        cell.labelChange.text = String(instruments[indexPath.row].change)+"%"
//
//        cell.labelName.textColor = theme.fontColor
//        cell.labelPrice.textColor = theme.fontColor
//        if (instruments[indexPath.row].change < 0){
//            cell.labelChange.textColor = theme.redColor
//        } else {
//            cell.labelChange.textColor = theme.greenColor
//        }
//        cell.labelQuantity.text = String(instruments[indexPath.row].quantity)
//        cell.labelQuantity.textColor = theme.valuesColor
//        cell.labelValue.text = String(instruments[indexPath.row].value)+"$"
//        cell.labelValue.textColor = theme.valuesColor
//
//        cell.backgroundColor = theme.cellColor
//
//        cell.layer.cornerRadius = 8
//        cell.layer.masksToBounds = true
//
//        let url = NSURL(string: instruments[indexPath.row].imageurl)! as URL
//        if let imageData: NSData = NSData(contentsOf: url) {
//            cell.imageIcon.image = UIImage(data: imageData as Data)
//        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        router.showPortfolioInstrument(instrument: instruments[indexPath[1]])
    }
    
    
    
}
