import CoreData

struct CoreDataSource: CoreDataSourceProtocol {

    private let coreDataContext: NSManagedObjectContext

    init(coreDataContext: NSManagedObjectContext) {
        self.coreDataContext = coreDataContext
    }

    func fetchTransactionsFromCoreData(stock: Stock) -> [Transaction] {
        let request: NSFetchRequest<CDTransaction> = CDTransaction.fetchRequest()
        var stockPredicate = NSPredicate(value: true)
//        var pricePredicate = NSPredicate(value: true)

        if let text = stock.name, !text.isEmpty {
            stockPredicate = NSPredicate(format: "%K == %@", #keyPath(CDTransaction.stock.name), text)
        }
//
//        if let price = filter.price {
//            pricePredicate = NSPredicate(format: "%K == %@", #keyPath(CDTransaction.price), price)
//        }
//
//        let andPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [namePredicate, pricePredicate])
        request.predicate = stockPredicate
        do {
            return try coreDataContext.fetch(request).map { Transaction(with: $0) }
        } catch {
            print("Error when fetching transactions from core data: \(error)")
            return []
        }
    }

    func saveNewTransactions(_ transactions: [Transaction]) {
        do {
            let newIds = transactions.map { $0.identifier }
            try deleteAllTransactionsExcept(withIds: newIds)
        }
        catch {
            print("Error when deleting transactions from core data: \(error)")
        }

        transactions.forEach { transaction in
            do {
                let cdTransaction = try fetchTransaction(withId: transaction.identifier) ?? CDTransaction(context: coreDataContext)
                transaction.populate(cdTransaction, in: coreDataContext)
            } catch {
                print("Error when fetching/creating a transaction: \(error)")
            }

            do {
                try coreDataContext.save()
            } catch {
                print("Error when saving updated transaction: \(error)")
            }
        }
    }
    
    func saveNewTransaction(_ transaction: Transaction) {
        do {
            try deleteAllTransactionsExcept(withIds: [transaction.identifier])
        }
        catch {
            print("Error when deleting transactions from core data: \(error)")
        }

        do {
            let cdTransaction = try fetchTransaction(withId: transaction.identifier) ?? CDTransaction(context: coreDataContext)
            transaction.populate(cdTransaction, in: coreDataContext)
        } catch {
            print("Error when fetching/creating a transaction: \(error)")
        }

        do {
            try coreDataContext.save()
        } catch {
            print("Error when saving updated transaction: \(error)")
        }
    }

    func deleteTransaction(withId id: Int) {
        guard let transaction = try? fetchTransaction(withId: id) else { return }

        coreDataContext.delete(transaction)

        do {
            try coreDataContext.save()
        } catch {
            print("Error when saving after deletion of transaction: \(error)")
        }

    }

    private func fetchTransaction(withId id: Int) throws -> CDTransaction? {
        let request: NSFetchRequest<CDTransaction> = CDTransaction.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %u", #keyPath(CDTransaction.identifier), id)

        let cdResponse = try coreDataContext.fetch(request)
        return cdResponse.first
    }

    private func deleteAllTransactionsExcept(withIds ids: [Int]) throws {
        let request: NSFetchRequest<CDTransaction> = CDTransaction.fetchRequest()
        request.predicate = NSPredicate(format: "NOT %K IN %@", #keyPath(CDTransaction.identifier), ids)
        let transactionsToDelete = try coreDataContext.fetch(request)
        transactionsToDelete.forEach { coreDataContext.delete($0) }
        try coreDataContext.save()
    }

}
