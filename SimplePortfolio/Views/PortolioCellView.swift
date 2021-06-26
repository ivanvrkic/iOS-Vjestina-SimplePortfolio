//
//  PortolioCellView.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation

import UIKit

class PortfolioCellView: DiscoverCellView{
    
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
    
    internal var substackBottom: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackVertical.spacing = 5
        stackVertical.distribution = .fillEqually
//        substackBottom.addArrangedSubview(labelQuantity)
//        substackBottom.addArrangedSubview(labelValue)
//        stackVertical.addArrangedSubview(substackBottom)
//        imageIcon.autoSetDimensions(to: CGSize(width: 90, height: 90))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}


