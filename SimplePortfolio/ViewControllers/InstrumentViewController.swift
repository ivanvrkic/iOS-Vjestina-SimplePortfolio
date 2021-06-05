//
//  InstrumentViewController.swift
//  SimplePortfolio
//
//  Created by Lovre on 01/06/2021.
//

import Foundation
import UIKit
class InstrumentViewController: UIViewController{
    
    private var router:AppRouter!
    private var theme:ThemeProtocol!
    private var instrument:Instrument
    
    private var leadingMargin:CGFloat!
    private var titleMargin:CGFloat = 80
    private var smallMargin:CGFloat = 20
    
    //DIMENZIJE
    private var widthOfComponents:CGFloat!
    private var heightSmall:CGFloat = 30
    private var heightBig:CGFloat = 50
    
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
    
    private var stackVertical: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var stackHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var stack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    init(router: AppRouter,instrument:Instrument){
        self.router = router
        self.instrument = instrument
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        theme = getCurrentTheme()
        styleViews()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        stackVertical.addArrangedSubview(labelName)
        stackVertical.addArrangedSubview(labelPrice)
        stackVertical.addArrangedSubview(labelChange)
        stackHorizontal.addArrangedSubview(imageIcon)
        stackHorizontal.addArrangedSubview(stackVertical)
        stack.addArrangedSubview(stackHorizontal)
        stack.addArrangedSubview(labelMarketCap)
        stack.addArrangedSubview(labelVolume)
        stack.addArrangedSubview(labelDescription)
        view.addSubview(stack)
        
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
        
        stack.autoPinEdge(toSuperviewEdge: .leading,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .trailing,withInset: leadingMargin)
        stack.autoPinEdge(toSuperviewEdge: .top,withInset: titleMargin)
        
        imageIcon.autoSetDimensions(to: CGSize(width: 80, height: 80))
    }
    
    private func styleViews(){
        view.backgroundColor = theme.backgroundColor
        labelPrice.textColor = theme.fontColor
        labelPrice.text = String(instrument.price)+"$"
        labelChange.text = String(instrument.change)+"%"
        labelName.textColor = theme.fontColor
        labelName.text = instrument.name
        if (instrument.change < 0){
            labelChange.textColor = theme.redColor
        } else {
            labelChange.textColor = theme.greenColor
        }
        labelMarketCap.text = "Market cap: "+String(instrument.marketCap)+"$"
        labelMarketCap.textColor = theme.fontColor
        labelVolume.text = "Volume: "+String(instrument.volume)+"$"
        labelVolume.textColor = theme.fontColor
        labelDescription.text = instrument.description
        labelDescription.textColor = theme.fontColor
        let url = NSURL(string: instrument.imageurl)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            imageIcon.image = UIImage(data: imageData as Data)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        widthOfComponents = self.view.frame.size.width * 0.8
        leadingMargin = self.view.frame.size.width * 0.1
    }
    
}
