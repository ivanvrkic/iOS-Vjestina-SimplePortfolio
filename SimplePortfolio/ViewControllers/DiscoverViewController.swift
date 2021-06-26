//
//  DiscoverViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//

import Foundation
import Foundation
import UIKit
class DiscoverViewController: UIViewController{
    
    private var router:AppRouter!
    private var theme:ThemeProtocol!
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 30
    private var smallMargin:CGFloat = 20
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightSmall:CGFloat = 30
    private var heightBig:CGFloat = 50
    
    private var instruments:[Stock]!
    private var presenter:Presenter!
    
    private var labelTitle: UILabel = {
        let label = UILabel()
        label.text = "DISCOVER"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .center
        return label
    }()
    
    private var textSearch: UITextField = {
        let field = UITextField()
        field.borderStyle = UITextField.BorderStyle.roundedRect
        return field
    }()
    
    private var buttonSearch:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(btnSearch), for: .touchUpInside)
        return btn
    }()
    
    private var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.register(DiscoverCellView.self, forCellReuseIdentifier: "DiscoverCell")
        view.rowHeight = 70
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
        presenter = Presenter()
        instruments = presenter.fetchForDiscovery()
        tableView.delegate = self
        tableView.dataSource = self
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(textSearch)
        textSearch.addSubview(buttonSearch)
        view.addSubview(stack)
        
        widthOfComponents = self.view.frame.size.width * 0.97
        leadingMargin = self.view.frame.size.width * 0.1
        
        stack.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .top, withInset: titleMargin)
        
        
        buttonSearch.autoAlignAxis(toSuperviewAxis: .horizontal)
        buttonSearch.autoPinEdge(toSuperviewEdge: .trailing,withInset: 5)
        
        view.addSubview(tableView)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        tableView.autoPinEdge(.top, to: .bottom, of: stack,withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        //tableView.autoSetDimensions(to: CGSize(width: 200, height: 300))
        
    }
    
    private func styleViews(){
        view.backgroundColor = theme.backgroundColor
        
//        labelTitle.textColor = theme.fontColor
        textSearch.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: theme.fontColor])
        textSearch.textColor = theme.placeholderColor
        textSearch.backgroundColor = theme.textFieldColor
        
        let icon = UIImage(systemName: "magnifyingglass.circle.fill")?.withTintColor(theme.backgroundColor, renderingMode: .alwaysOriginal)
        buttonSearch.setImage(icon, for: .normal)
        
        tableView.backgroundColor = theme.backgroundColor
        tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.97
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    @objc private func btnSearch(){
        let filter = textSearch.text
        if(filter == nil){
            
            instruments = presenter.fetchForDiscovery()
            tableView.reloadData()
        } else {
            presenter.fetchStocks(keyword: filter!, completionHandler: { stocks in
                DispatchQueue.main.async {
                self.instruments = stocks
                self.tableView.reloadData()
                }
            })
            
        }
    }
    
}

extension DiscoverViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instruments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:DiscoverCellView!
        cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath as IndexPath) as! DiscoverCellView
        
        cell.labelName.text = instruments[indexPath.row].name
        cell.labelSymbol.text = instruments[indexPath.row].symbol

//        cell.labelPrice.text = String(instruments[indexPath.row].price)+"$"
//        cell.labelChange.text = String(instruments[indexPath.row].change)+"%"
//
        cell.labelName.textColor = theme.fontColor
        cell.labelSymbol.textColor = theme.fontColor
//        za search api call imamo samo stock symbol i name
//        if (instruments[indexPath.row].change < 0){
//            cell.labelChange.textColor = theme.redColor
//        } else {
//            cell.labelChange.textColor = theme.greenColor
//        }
        
        cell.backgroundColor = theme.cellColor
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
//        let url = NSURL(string: instruments[indexPath.row].imageurl)! as URL
//        if let imageData: NSData = NSData(contentsOf: url) {
//            cell.imageIcon.image = UIImage(data: imageData as Data)
//        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        router.showInstrument(instrument: instruments[indexPath[1]])
    }
    
    
    
}


extension DiscoverViewController:UITableViewDelegate{
    
}
