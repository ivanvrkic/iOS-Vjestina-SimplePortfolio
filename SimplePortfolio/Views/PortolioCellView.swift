//
//  PortolioCellView.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation

import UIKit

class PortfolioCellView: UITableViewCell{
    
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
    
    var labelChange:UILabel = {
        let label = UILabel()
        label.text = "change"
        return label
    }()
    
    var imageIcon:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private var stackHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var stackVertical: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var substackTop: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private var substackBottom: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackHorizontal.addArrangedSubview(imageIcon)
        stackHorizontal.addArrangedSubview(stackVertical)
        stackVertical.addArrangedSubview(labelName)
        stackVertical.addArrangedSubview(substackTop)
        stackVertical.addArrangedSubview(substackBottom)
        substackTop.addArrangedSubview(labelPrice)
        substackTop.addArrangedSubview(labelChange)
        substackBottom.addArrangedSubview(labelQuantity)
        substackBottom.addArrangedSubview(labelValue)
        addSubview(stackHorizontal)
        
        stackHorizontal.autoPinEdge(toSuperviewEdge: .leading)
        stackHorizontal.autoPinEdge(toSuperviewEdge: .top)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    
}


