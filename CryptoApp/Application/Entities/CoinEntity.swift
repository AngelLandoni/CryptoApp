//
//  CoinEntity.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct CoinEntity {
    var id: Int?
    var name: String?
    var percentChange1H: String?
    var priceUSD: String?
    
    init() {  }
    
    init(withModel model: CoinModel) {
        id = model.id
        name = model.name
        percentChange1H = model.percentChange1H
        priceUSD = model.priceUSD
    }
}
