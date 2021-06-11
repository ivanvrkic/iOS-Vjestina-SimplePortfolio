//
//  DiscoverCellView.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation
import UIKit

class DiscoverCellView: UITableViewCell{
    
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
    
    var imageIcon:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    internal var stackHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    internal var stackVertical: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 15
        return view
    }()
    
    internal var substackTop: UIStackView = {
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
        substackTop.addArrangedSubview(labelPrice)
        substackTop.addArrangedSubview(labelChange)
        addSubview(stackHorizontal)
        
        stackHorizontal.autoPinEdge(toSuperviewEdge: .leading,withInset: 15)
        //stackHorizontal.autoPinEdge(toSuperviewEdge: .top)
        stackHorizontal.autoAlignAxis(toSuperviewAxis: .horizontal)
        //stackHorizontal.autoAlignAxis(toSuperviewAxis: .vertical)
        
        imageIcon.autoSetDimensions(to: CGSize(width: 60, height: 60))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    
}


