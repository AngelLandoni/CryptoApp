//
//  CoinPortfolioEntity.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Foundation

struct CoinPortfolioEntity {
    var id: Int?
    var amount: Double?
    var priceUSD: Double?
    
    init(withModel model: CoinPortfolioModel) {
        id = model.id ?? 0
        amount = model.amount ?? 0.0
        priceUSD = model.priceUSD ?? 0.0
    }
    
    init(withDBModel dbModel: PortfolioItemDBModel) {
        id = dbModel.coinId ?? 0
        amount = dbModel.amount ?? 0.0
        priceUSD = dbModel.priceUSD ?? 0.0
    }
}
