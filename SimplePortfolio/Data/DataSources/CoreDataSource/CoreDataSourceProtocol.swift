//
//  CoreDataSourceProtocol.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 27.06.2021..
//

import Foundation

protocol CoreDataSourceProtocol {
    func fetchTransactionsFromCoreData(stock: Stock) -> [Transaction]
//    func saveNewTransactions(_ transactions: [Transaction])
    func saveNewTransaction(_ transaction: Transaction)
    func deleteTransaction(withId id: UUID)
}
