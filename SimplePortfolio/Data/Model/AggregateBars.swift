//
//  StockAPIResponse.swift
//  RHLinePlotExample
//
//  Created by Ivan Vrkic on 6/15/21.
//  Copyright © 2021 Ivan Vrkic. All rights reserved.

//  Used to represent aggregate bars data for graphing from Polygon's API call

import Foundation

struct StockStatsInfo: Decodable {
    let closePrice: Float
    init(closePrice: Double) { self.closePrice = Float(closePrice) }
}

// MARK: - StockInfo
struct StockInfo: Codable {
    let ticker: String
    let queryCount, resultsCount: Int
    let adjusted: Bool
    let results: [Result]
    let status, requestID: String
    let count: Int

    enum CodingKeys: String, CodingKey {
        case ticker, queryCount, resultsCount, adjusted, results, status
        case requestID = "request_id"
        case count
    }
}

// MARK: - Result
struct Result: Codable {
    let v: Int
    let vw, o, c, h: Double
    let t, l: Double
    let n: Int
}

struct AggregateBars: Decodable {
    
    let symbol: String
    let timeSeries: [(time: Date, info: StockStatsInfo)] //  [StockInfo]
    
    enum CodingKeys: String, CodingKey {
        case ticker, queryCount, resultsCount, adjusted, results, status
        case requestID = "request_id"
        case count
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self )
        let results = try container.decodeIfPresent([Result].self, forKey: .results)
        var entities: [(time: Date, info: StockStatsInfo)] = []
        try results?.forEach({ val in
            var t = Date(timeIntervalSince1970: Double(val.t)/1000)
            entities.append((t, StockStatsInfo(closePrice: val.c)))
        })
        self.timeSeries = entities.sorted(by: { (s1, s2) -> Bool in
            s1.time < s2.time
        })
        symbol = try container.decode(String.self, forKey: .ticker)
    }
}
