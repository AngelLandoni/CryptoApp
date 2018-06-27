//
//  CoinDetailEntity.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct CoinDetailEntity {
    var id: Int?
    var name: String?
    var percentChange1H: String?
    var priceBTC: String?
    var priceUSD: String?
    
    var symbol: String?
    var rank: Int?
    var totalSupply: Int?
    var updatedAt: String?
    
    init(withModel model: CoinModel) {
        id = model.id
        name = model.name
        percentChange1H = model.percentChange1H
        priceUSD = model.priceUSD
        priceBTC = model.priceBTC
        symbol = model.symbol
        rank = model.rank
        totalSupply = model.totalSupply
        updatedAt = model.updatedAt
    }
}
