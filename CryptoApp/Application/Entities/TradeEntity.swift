//
//  TradeEntity.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Foundation

struct TradeEntity {
    var coinId: Int?
    var priceUSD: Float?
    var amount: Float?
    var date: Date?
    
    init(withModel model: TradeModel) {
        coinId = model.coinId
        priceUSD = model.priceUSD
        amount = model.amount
        date = DateHandler.fromStringToDate(buffer: model.tradeAt ?? "")
    }
}
