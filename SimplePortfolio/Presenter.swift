//
//  Presenter.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation
protocol DiscoveryPresenter{
    func fetchForDiscovery() -> [Instrument]
    func fetchFiltered(filter:String) -> [Instrument]
}

protocol PortfolioPresenter{
    func fetchForPortfolio() -> [Instrument]
    func fetchTransactions(instrument: Instrument) -> [Transaction]
    func makeTransaction(transaction:Transaction) -> Void
    func fetchStatus() -> Status
}
class Presenter:DiscoveryPresenter,PortfolioPresenter{
    func fetchForPortfolio() -> [Instrument] {
        
        
        instruments = DataService().fetchForDiscovery()
        return instruments
    }
    
    func fetchTransactions(instrument: Instrument) -> [Transaction] {
        return transactions
    }
    
    func makeTransaction(transaction: Transaction) {
        print("Dodano")
    }
    
    func fetchStatus() -> Status {
        let status = Status(valueOfPortfolio: 500.0, changeInCurrency: 20.0, changeInPercentage: 3.0)
        return status
    }
    
    var instruments:[Instrument]!
    var transactions:[Transaction]!
    
    func fetchForDiscovery() -> [Instrument]{
        instruments = DataService().fetchForDiscovery()
        return instruments
    }
    func fetchFiltered(filter:String) -> [Instrument]{
        var new:[Instrument]! = []
        let data = DataService().fetchForDiscovery()
        for ins in data{
            if (ins.name.contains(filter)){
                new.append(ins)
            }
        }
        return new
    }
}

class DataService{
    func fetchForDiscovery() -> [Instrument]{
        let i1 = Instrument(name: "apple", quantity: 5, price: 300, change: 2.50, marketCap: 1000, volume: 1000, description: "des", imageurl: "")
        let i2 = Instrument(name: "oil", quantity: 2, price: 200, change: -0.5, marketCap: 1000, volume: 1000, description: "des", imageurl: "")
        return [i1,i2]
    }
}
