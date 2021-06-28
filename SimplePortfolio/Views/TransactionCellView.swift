//
//  TransactionCellView.swift
//  SimplePortfolio
//
//  Created by Lovre on 11/06/2021.
//

import Foundation
import UIKit

class TransactionCellView: UITableViewCell{
    
    var labelAction:UILabel = UILabel()
    var labelQuantity:UILabel = UILabel()
    private var labelFor:UILabel = {
        let label = UILabel()
        label.text = "for"
        return label
    }()
    var labelPrice:UILabel = UILabel()
    private var stackHorizontal: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        stackHorizontal.addArrangedSubview(labelAction)
        stackHorizontal.addArrangedSubview(labelQuantity)
        stackHorizontal.addArrangedSubview(labelFor)
        stackHorizontal.addArrangedSubview(labelPrice)
        self.addSubview(stackHorizontal)
        
        stackHorizontal.autoAlignAxis(toSuperviewAxis: .horizontal)
        stackHorizontal.autoAlignAxis(toSuperviewAxis: .vertical)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    
}


