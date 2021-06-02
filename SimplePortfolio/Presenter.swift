//
//  Presenter.swift
//  SimplePortfolio
//
//  Created by Lovre on 02/06/2021.
//

import Foundation
class Presenter{
    func fetchForDiscovery() -> [Instrument]{
        return DataService().fetchForDiscovery()
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
