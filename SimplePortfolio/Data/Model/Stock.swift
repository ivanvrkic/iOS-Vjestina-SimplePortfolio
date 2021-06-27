//
//  Stock.swift
//  SimplePortfolio
//
//  Created by Ivan Vrkic on 25.06.2021..
//

import Foundation

struct Stock: Codable {
    var symbol: String?
    var name: String?
    
    private enum CodingKeys : String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
    }
}
