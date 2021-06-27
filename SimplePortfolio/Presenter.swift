//
//  Presenter.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation
protocol DiscoveryPresenter{
    func fetchForDiscovery() -> [Stock]
//    func fetchFiltered(filter:String) -> [Instrument]
}

protocol PortfolioPresenter{
    func fetchForPortfolio() -> [Stock]
    func fetchTransactions(instrument: Stock) -> [Transaction]
    func makeTransaction(transaction:Transaction) -> Void
    func fetchStatus() -> Status
}

class Presenter:DiscoveryPresenter,PortfolioPresenter{
    
    var stocks:[Stock]!
    var transactions:[Transaction]!
    private let dataRepository: DataRepository
    private let dataService: DataService
    
    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
        self.dataService = DataService()
    }
    
    func fetchForPortfolio() -> [Stock] {
        stocks = dataService.fetchForDiscovery()
        return stocks
    }
    
    func fetchTransactions(instrument: Stock) -> [Transaction] {
        dataRepository.fetchLocalData(stock: instrument)
    }
    
    func makeTransaction(transaction: Transaction) {
        do {
            try dataRepository.saveNewLocalData(transaction: transaction)
        }
        catch {
            print("Error making a transaction: \(error)")
        }
    }
    
    func fetchStatus() -> Status {
        let status = Status(valueOfPortfolio: 500.0, changeInCurrency: 20.0, changeInPercentage: 3.0)
        return status
    }
    
    func fetchForDiscovery() -> [Stock]{
        stocks = dataService.fetchForDiscovery()
        return stocks
    }
//    func fetchFiltered(filter:String) -> [Instrument]{
////        var new:[Instrument]! = []
////        let data = DataService().fetchForDiscovery()
////        for ins in data{
////            if (ins.name.contains(filter)){
////                new.append(ins)
////            }
////        }
////        return new
//    }
    
    func fetchStocks(keyword: String, completionHandler: @escaping ([Stock]) -> Void) {
        dataService.fetchStocks(keyword: keyword){ stocks in
            completionHandler(stocks)
        }
    }
    
    func fetchStockGlobalQuote(symbol: String, completionHandler: @escaping (GlobalQuote) -> Void) {
        dataService.fetchStockGlobalQuote(symbol: symbol){ stockQuote in
            completionHandler(stockQuote)
        }
    }

//    func getTransactions(stock: Stock) -> [Transaction] {
//
//    }

    func deleteTransaction(withId id: Int) {
        dataRepository.deleteLocalData(withId: id)
    }

}


