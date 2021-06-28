//
//  DataRepository.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 27.06.2021..
//
import Foundation
class DataRepository {

    private let coreDataSource: CoreDataSourceProtocol

    init(coreDataSource: CoreDataSourceProtocol) {
        self.coreDataSource = coreDataSource
    }

//    func fetchRemoteData() throws {
//        let restaurants = try jsonDataSource.fetchRestaurantsFromJson()
//        coreDataSource.saveNewRestaurants(restaurants)
//    }
    
//    func fetchRemoteData() throws {
//        jsonDataSource.fetchTransactionsFromJson(){ (restaurants) in
//            self.coreDataSource.saveNewRestaurants(restaurants)
//        }
//    }
    func saveNewLocalData(transaction: Transaction) throws {
        self.coreDataSource.saveNewTransaction(transaction)
        
    }
    
    func fetchLocalData(stock: Stock) -> [Transaction] {
        coreDataSource.fetchTransactionsFromCoreData(stock: stock)
    }

    func deleteLocalData(withId id: UUID) {
        coreDataSource.deleteTransaction(withId: id)
    }
}
