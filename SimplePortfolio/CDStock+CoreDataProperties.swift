//
//  CDStock+CoreDataProperties.swift
//  
//
//  Created by Ivan Vrkic on 27.06.2021..
//
//

import Foundation
import CoreData


extension CDStock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStock> {
        return NSFetchRequest<CDStock>(entityName: "CDStock")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var name: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension CDStock {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: CDTransaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: CDTransaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}
