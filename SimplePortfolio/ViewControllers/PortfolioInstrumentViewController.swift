//
//  PortfolioInstrumentViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 01/06/2021.
//

import Foundation
import UIKit
class PortfolioInstrumentViewController: InstrumentViewController, UITableViewDelegate{
    
    private var transactions:[Transaction]!
    private var presenter:Presenter!
    private var totalQuantity: Float?
    var labelQuantity:UILabel = {
        let label = UILabel()
        label.text = "quantity"
        return label
        
    }()
    
    var labelValue:UILabel = {
        let label = UILabel()
        label.text = "value"
        return label
        
    }()
    
    var addButton:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action:#selector(buyPressed), for: .touchUpInside)
        btn.setTitle("Buy", for: .normal)
        return btn
    }()
    
    var removeButton:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action:#selector(sellPressed), for: .touchUpInside)
        btn.setTitle("Sell", for: .normal)
        return btn
    }()
    
    private var stackButtons: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()
    
    private var tableView: UITableView = {
        let view = UITableView()
        view.register(TransactionCellView.self, forCellReuseIdentifier: "TransactionCell")
        view.rowHeight = 30
        return view
    }()
    
    override init(router: AppRouter,instrument:Stock){
        super.init(router: router, instrument: instrument)
        presenter = router.getPresenter()
        transactions = presenter.fetchTransactions(instrument: instrument)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func styleViews(){
        super.styleViews()
        labelValue.textColor = theme.fontColor
//        labelValue.text = String(instrument.value)+"$"
        labelValue.font = UIFont.preferredFont(forTextStyle: .title2)
        
//        labelQuantity.text = String(instrument.quantity)
        labelQuantity.textColor = theme.fontColor
        labelQuantity.font = UIFont.preferredFont(forTextStyle: .title2)
        
        addButton.backgroundColor = theme.greenColor
        addButton.tintColor = theme.fontColor
        
        removeButton.backgroundColor = theme.redColor
        removeButton.tintColor = theme.fontColor
        
        tableView.backgroundColor = theme.backgroundColorSecond
        tableView.reloadData()
        calculateInstrumentData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        stack.removeArrangedSubview(labelMarketCap)
        labelMarketCap.removeFromSuperview()
        stack.removeArrangedSubview(labelVolume)
        labelVolume.removeFromSuperview()
        stack.removeArrangedSubview(labelDescription)
        labelDescription.removeFromSuperview()
        stack.addArrangedSubview(labelQuantity)
        stack.addArrangedSubview(labelValue)
        
        stackButtons.addArrangedSubview(addButton)
        stackButtons.addArrangedSubview(removeButton)
        stack.addArrangedSubview(stackButtons)
        
        view.addSubview(tableView)
        tableView.autoPinEdge(toSuperviewEdge: .leading, withInset: leadingMargin)
        tableView.autoPinEdge(toSuperviewEdge: .trailing, withInset: leadingMargin)
        tableView.autoPinEdge(.top, to: .bottom, of: stack,withOffset: 10)
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        
        removeButton.autoSetDimensions(to: CGSize(width: widthOfComponents/2, height: 30))
        addButton.autoSetDimensions(to: CGSize(width: widthOfComponents/2, height: 30))
        
    }
    
    func calculateInstrumentData(){
        calculateTotalQuantity()
        labelQuantity.text = "Total shares: \(totalQuantity!)"
        labelValue.text = "Value:" + String(Float(stockQuote!.price)!*totalQuantity!)+"$"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sellPressed(){
        router.presentTransaction(instrument: instrument, transactionType: .sell, price: Float(stockQuote!.price)!)
    }
    
    @objc private func buyPressed(){
        router.presentTransaction(instrument: instrument, transactionType: .buy, price: Float(stockQuote!.price)!)
    }
    func reload() {
        tableView.reloadData()
        calculateInstrumentData()
    }
    func calculateTotalQuantity(){
        totalQuantity=0
        for t in transactions{
            if (t.type == .buy){
            totalQuantity!+=t.quantity
            continue
            }
            totalQuantity!-=t.quantity
        }
    }
}

extension PortfolioInstrumentViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions = presenter.fetchTransactions(instrument: instrument)
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TransactionCellView!
        cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath as IndexPath) as! TransactionCellView
        
        if(transactions[indexPath[1]].type == .buy){
            cell.labelAction.text = "Buy"
            cell.labelAction.textColor = theme.greenColor
        } else {
            cell.labelAction.text = "Sell"
            cell.labelAction.textColor = theme.redColor
        }
        cell.labelQuantity.text = String(transactions[indexPath[1]].quantity)
        cell.labelPrice.text = String(transactions[indexPath[1]].priceAtMoment)+"$"
        
        cell.backgroundColor = theme.cellColor
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        return cell
        
    }
    
}
