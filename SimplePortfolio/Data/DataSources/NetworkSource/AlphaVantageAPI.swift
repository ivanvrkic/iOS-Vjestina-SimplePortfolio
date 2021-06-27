//
//  NetworkService.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 25.06.2021..
//

import Foundation

class DataService{
    func fetchForDiscovery() -> [Stock]{
        let i1 = Stock(symbol: "AAPL", name: "Apple")
        let i2 = Stock(symbol: "TWTR", name: "Twitter")
        return [i1,i2]
    }
    
    func fetchTransactions() -> [Transaction]{
        let i1 = Stock(symbol: "AAPL", name: "Apple")
        let c1 = Transaction(identifier: 1, quantity: 3, instrument: i1, priceAtMoment: 200, type: .buy)
        let c2 = Transaction(identifier: 2, quantity: 2, instrument: i1, priceAtMoment: 300, type: .sell)
        return [c1,c2]
    }
    
    func fetchStocks(keyword: String, completionHandler: @escaping ([Stock]) -> Void){
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keyword)&apikey=9BD1Q7Q5BUQKQ7S7"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("err \(error)")
            }
            
            do {
                let stocksList = try JSONDecoder().decode(Stocks.self, from: data ?? Data())
                completionHandler(stocksList.bestMatches)
            } catch {
                print("JSON err \(error)")
            }
        }
        task.resume()
    }
    func fetchStockGlobalQuote(symbol: String, completionHandler: @escaping (GlobalQuote) -> Void){
        let urlString = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=9BD1Q7Q5BUQKQ7S7"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("err \(error)")
            }
            
            do {
                let stockGlobalQuote = try JSONDecoder().decode(StockGlobalQuote.self, from: data ?? Data())
                completionHandler(stockGlobalQuote.globalQuote)
            } catch {
                print("JSON err \(error)")
            }
        }
        task.resume()
    }
    
}
