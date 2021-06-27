//
//  StockInfo.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 20.06.2021..
//

import Foundation

// MARK: - StockGlobalQuote
struct StockGlobalQuote: Codable {
    let globalQuote: GlobalQuote

    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

// MARK: - GlobalQuote
struct GlobalQuote: Codable {
    let symbol, open, high, low: String
    let price, volume, latestTradingDay, previousClose: String
    let change, changePercent: String

    enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case latestTradingDay = "07. latest trading day"
        case previousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
}
