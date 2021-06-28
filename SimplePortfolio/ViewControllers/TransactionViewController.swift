//
//  TransactionViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 31/05/2021.
//

import Foundation
import UIKit

class TransactionViewController:UIViewController {
    
    private var transactionType:TransactionType!
    private var transaction:Transaction!
    private var instrument:Stock!
    private var router:AppRouter!
    private var theme:ThemeProtocol!
    private var presenter:Presenter!
    private var price:Float!
    
    private var widthOfComponents:CGFloat!
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 80
    
    var labelTitle:UILabel = {
        let label = UILabel()
        label.text = "title"
        return label
    }()
    
    var textQuantity:UITextField = {
        let text = UITextField()
        text.placeholder = "Enter quantity"
        return text
    }()
    
    var textPrice:UITextField = {
        let text = UITextField()
        text.placeholder = "Enter price"
        return text
    }()
    
    var button:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action:#selector(buttonPressed), for: .touchUpInside)
        return btn
    }()
    
    internal var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    init(router:AppRouter,instrument:Stock, transactionType:TransactionType, price: Float){
        self.router = router
        self.instrument = instrument
        self.transactionType = transactionType
        self.price = price
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter = router.getPresenter()
        theme = getCurrentTheme()
        styleViews()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(textQuantity)
        stack.addArrangedSubview(button)
        view.addSubview(stack)
        
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
        
        stack.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
    
    }
    
    internal func styleViews(){
        view.backgroundColor = theme.backgroundColor
        labelTitle.textColor = theme.fontColor
        if (transactionType == .buy){
            button.setTitle("Buy", for: .normal)
            button.backgroundColor = theme.greenColor
            labelTitle.text = "Buy "+instrument.name!
        } else if (transactionType == .sell) {
            button.setTitle("Sell", for: .normal)
            button.backgroundColor = theme.redColor
            labelTitle.text = "Sell "+instrument.name!
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.97
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    @objc private func buttonPressed(){
        let quantity = Float(textQuantity.text!)
        let transaction = Transaction(identifier: UUID(), quantity: quantity!, instrument: instrument, priceAtMoment: price, type: transactionType)
        presenter.makeTransaction(transaction: transaction)
        router.dismiss()
    }
    
}
