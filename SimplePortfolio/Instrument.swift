//
//  Instrument.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation
struct Instrument{
    var name:String
    var quantity:Float
    var price:Float
    var change:Float
    var marketCap:Float
    var volume:Float
    var description:String
    var imageurl:String
}

class DataService {
    
    func fetchForDiscovery()->[Instrument]{
        let i1 = Instrument(name: "apple", quantity: 1, price: 1, change: 0, marketCap: 1, volume: 1, description: "description neki koji je ovako ja dug i mnogo mnogo mnogo dug", imageurl: "https://upload.wikimedia.org/wikipedia/commons/a/ab/Apple-logo.png")
        let i2 = Instrument(name: "oil", quantity: 1, price: 1, change: 0, marketCap: 1, volume: 1, description: "description", imageurl: "https://upload.wikimedia.org/wikipedia/commons/a/ab/Apple-logo.png")
        return [i1,i2]
    }
    
}
