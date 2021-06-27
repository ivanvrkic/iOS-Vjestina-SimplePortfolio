//
//  Transaction+CD.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 20.06.2021..
//
import CoreData
import UIKit

extension Transaction {

    init(with entity: CDTransaction) {
        identifier = Int(entity.identifier)
        quantity = entity.quantity
        instrument = Stock(with: entity.stock!)
        priceAtMoment = entity.priceAtMoment
        type = entity.type
    }

    func populate(_ entity: CDTransaction, in context: NSManagedObjectContext) {
        entity.identifier = Int16(identifier)
        entity.quantity = quantity
        entity.priceAtMoment = priceAtMoment
        entity.type = type
        let cdStock = CDStock(context: context)
        instrument.populate(cdStock)
        entity.stock = cdStock
    }

}
