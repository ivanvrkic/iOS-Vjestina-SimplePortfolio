//
//  InstrumentViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 01/06/2021.
//

import Foundation
import UIKit
class InstrumentViewController: UIViewController{
    
    internal var router:AppRouter!
    internal var theme:ThemeProtocol!
    internal var instrument:Stock
    
    private var presenter:Presenter!
    
    internal var leadingMargin:CGFloat!
    internal var titleMargin:CGFloat = 100
    internal var smallMargin:CGFloat = 20
    
    //DIMENZIJE
    internal var widthOfComponents:CGFloat!
    internal var heightSmall:CGFloat = 30
    internal var heightBig:CGFloat = 50
    
    var labelSymbol:UILabel = {
        let label = UILabel()
        label.text = "symbol"
        label.font=UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.black)
        return label
    }()
    
    var labelName:UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    var labelPrice:UILabel = {
        let label = UILabel()
        label.text = "price"
        return label
    }()
    
    var labelChange:UILabel = {
        let label = UILabel()
        label.text = "change"
        return label
    }()
    var labelChangePercent:UILabel = {
        let label = UILabel()
        label.text = "change percent"
        return label
    }()
    var labelMarketCap:UILabel = {
        let label = UILabel()
        label.text = "market cap"
        return label
    }()
    
    var labelVolume:UILabel = {
        let label = UILabel()
        label.text = "volume"
        return label
    }()
    
    var labelDescription:UILabel = {
        let label = UILabel()
        label.text = "description"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var imageIcon:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    internal var stackVertical: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    internal var stackHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    internal var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    init(router: AppRouter,instrument:Stock){
        self.router = router
        self.instrument = instrument
        super.init(nibName: nil, bundle: nil)
        presenter = Presenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewWillAppear(_ animated: Bool) {
        theme = getCurrentTheme()
        fetchInfo()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        stack.addArrangedSubview(labelSymbol)
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(labelPrice)
        stack.addArrangedSubview(labelChange)
        stack.addArrangedSubview(labelChangePercent)
        stack.addArrangedSubview(stackHorizontal)
//        stack.addArrangedSubview(labelMarketCap)
        stack.addArrangedSubview(labelVolume)
//        stack.addArrangedSubview(labelDescription)
        view.addSubview(stack)
        
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
        
        stack.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
        
        imageIcon.autoSetDimensions(to: CGSize(width: 80, height: 80))
    }
    
    internal func styleViews(stockQuote: GlobalQuote){
        view.backgroundColor = theme.backgroundColor
        labelSymbol.text=stockQuote.symbol
        labelSymbol.textColor = theme.fontColor
        labelPrice.textColor = theme.fontColor
        labelPrice.text = String(stockQuote.price)+"$"
        labelChange.text = String(stockQuote.change)+"$"
        labelChangePercent.text = String(stockQuote.changePercent)
        labelName.textColor = theme.fontColor
        labelName.text = instrument.name
        if (Double(stockQuote.change)! < 0){
            labelChange.textColor = theme.redColor
        } else {
            labelChange.textColor = theme.greenColor
        }
//        labelMarketCap.text = "Market cap: "+String(instrument.marketCap)+"$"
//        labelMarketCap.textColor = theme.fontColor
        labelVolume.text = "Volume: "+String(stockQuote.volume)+"$"
        labelVolume.textColor = theme.fontColor
//        labelDescription.text = instrument.description
//        labelDescription.textColor = theme.fontColor
//        let url = NSURL(string: instrument.imageurl)! as URL
//        if let imageData: NSData = NSData(contentsOf: url) {
//            imageIcon.image = UIImage(data: imageData as Data)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
    func fetchInfo() {
        presenter.fetchStockGlobalQuote(symbol: instrument.symbol!) { stockQuote in
            DispatchQueue.main.async {
                self.styleViews(stockQuote: stockQuote)
            }
        }
    }
        
}
