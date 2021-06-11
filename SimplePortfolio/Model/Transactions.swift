//
//  Transactions.swift
//  SimplePortfolio
//
//  Created by Lovre on 05/06/2021.
//

import Foundation
struct Transaction{
    let quantity: Float
    let instrument: Instrument
    let priceAtMoment: Float
    let type: TransactionType
}
