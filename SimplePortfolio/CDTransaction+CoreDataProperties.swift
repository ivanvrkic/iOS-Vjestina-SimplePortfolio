//
//  CDTransaction+CoreDataProperties.swift
//  
//
//  Created by Ivan Vrkic on 27.06.2021..
//
//

import Foundation
import CoreData


extension CDTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTransaction> {
        return NSFetchRequest<CDTransaction>(entityName: "CDTransaction")
    }

    @NSManaged public var quantity: Float
    @NSManaged public var priceAtMoment: Float
    @NSManaged public var type: TransactionType
    @NSManaged public var stock: CDStock?
    @NSManaged public var identifier: UUID
}
