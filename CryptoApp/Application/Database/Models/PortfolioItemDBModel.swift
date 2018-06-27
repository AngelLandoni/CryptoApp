//
//  PortfolioItemDBModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import RealmSwift
import Realm

final class PortfolioItemDBModel: Object {
    @objc dynamic var ID: String = ""
    @objc dynamic var coinId: Int = 0
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var priceUSD: Double = 0.0
    @objc dynamic var date: Date = Date()
    
    override static func primaryKey() -> String? { return "ID" }
    
    init(withCoin coin: CoinEntity, andAmount amount: Double) {
        super.init()
        ID = NSUUID().uuidString
        coinId = coin.id ?? 0
        priceUSD = Double(coin.priceUSD ?? "0.0") ?? 0.0
        self.amount = amount
        date = Date()
    }

    init(withTrade trade: TradeEntity) {
        super.init()
        ID = NSUUID().uuidString
        coinId = trade.coinId ?? 0
        priceUSD = Double(trade.priceUSD ?? 0.0)
        self.amount = Double(trade.amount ?? 0.0)
        date = trade.date ?? Date()
    }
    
    required init() { super.init() }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}
