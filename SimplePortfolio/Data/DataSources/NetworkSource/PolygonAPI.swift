//
//  AggregateBars.swift
//  RHLinePlotExample
//
//  Created by Ivan Vrkic on 6/15/21.
//  Copyright © 2021 Ivan Vrkic. All rights reserved.
//

import Foundation
import Combine

struct PolygonAPI {
    static let networkActivity = PassthroughSubject<Bool, Never>()
        
    let symbol: String
    let interval: Interval
    var apiKey = "BxKMzrJ3f2rbKmH5EyReSFLMJy09wcz7"
    
    var path: String {
        let d = Date()
        switch interval {
        case .daily:
            let db = Calendar.current.date(byAdding: .day, value: -1, to: d)
            return "v2/aggs/ticker/\(symbol)/range/5/minute/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
             
        case .weekly:
            let db = Calendar.current.date(byAdding: .day, value: -7, to: d)
            return "v2/aggs/ticker/\(symbol)/range/15/minute/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
        case .monthly:
            let db = Calendar.current.date(byAdding: .month, value: -1, to: d)
            return "v2/aggs/ticker/\(symbol)/range/1/hour/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
        case .halfYearly:
            let db = Calendar.current.date(byAdding: .month, value: -6, to: d)
            return "v2/aggs/ticker/\(symbol)/range/1/day/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
        case .yearly:
            let db = Calendar.current.date(byAdding: .year, value: -1, to: d)
            return "v2/aggs/ticker/\(symbol)/range/1/day/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
        default:
            let db = Calendar.current.date(byAdding: .day, value: -1, to: d)
            return "v2/aggs/ticker/\(symbol)/range/5/minute/\(db!.getFormattedDate())/\(d.getFormattedDate())?unadjusted=false&sort=asc&limit=50000&apiKey=\(apiKey)"
        }
    }
    var apiUrl: URL {
        URL(string: "https://api.polygon.io/\(self.path)")!
    }
    
    var publisher: AnyPublisher<AggregateBars?, Never> {
        let url = URL(string: "https://api.polygon.io/\(self.path)")!
        print("URL: \(url) \(interval)")
        let publiser = URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveSubscription: { (_) in
                Self.networkActivity.send(true)
            }, receiveCompletion: { (completion) in
                Self.networkActivity.send(false)
            }, receiveCancel: {
                Self.networkActivity.send(false)
            })
            .map(\.data)
            .decode(type: AggregateBars?.self, decoder: JSONDecoder())
            .catch { (err) -> Just<AggregateBars?> in
                print("Catched Error \(err.localizedDescription)")
                return Just<AggregateBars?>(nil)
        }
        .eraseToAnyPublisher()
        return publiser
    }
}

extension PolygonAPI {
    enum Interval {
        case daily
        case weekly
        case monthly
        case halfYearly
        case yearly
    }
}

extension Date {
   func getFormattedDate() -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: self)
    }
}
