//
//  Stock+CD.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 27.06.2021..
//

import Foundation

import CoreData

extension Stock {

    init(with entity: CDStock) {
        name = entity.name
        symbol = entity.symbol
    }

    func populate(_ entity: CDStock) {
        entity.symbol = name
        entity.name = name
    }

}
