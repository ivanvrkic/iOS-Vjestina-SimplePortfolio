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
    
    
    func fetchForPortfolio() -> [Stock] {
        stocks = DataService().fetchForDiscovery()
        return stocks
    }
    
    func fetchTransactions(instrument: Stock) -> [Transaction] {
        transactions = DataService().fetchTransactions()
        return transactions
    }
    
    func makeTransaction(transaction: Transaction) {
        print("Dodano")
    }
    
    func fetchStatus() -> Status {
        let status = Status(valueOfPortfolio: 500.0, changeInCurrency: 20.0, changeInPercentage: 3.0)
        return status
    }
    
    func fetchForDiscovery() -> [Stock]{
        stocks = DataService().fetchForDiscovery()
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
        DataService().fetchStocks(keyword: keyword){ stocks in
            completionHandler(stocks)
        }
    }
}


