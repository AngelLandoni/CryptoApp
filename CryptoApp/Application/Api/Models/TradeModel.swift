//
//  TradeModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct TradeModel {
    var id: Int?
    var coinId: Int?
    var userId: Int?
    var priceUSD: Float?
    var totalUDS: Double?
    var amount: Float?
    
    var updatedAt: String?
    var tradeAt: String?
    var createdAt: String?
    
    init(withDictionary dictionary: [String: Any]) {
        id = (dictionary["id"] as? Int) ?? -1
        coinId = (dictionary["coin_id"] as? Int) ?? -1
        userId = (dictionary["user_id"] as? Int) ?? -1
        priceUSD = (dictionary["price_usd"] as? Float) ?? 0.0
        totalUDS = (dictionary["total_usd"] as? Double) ?? 0.0
        amount = (dictionary["amount"] as? Float) ?? 0.0
        
        updatedAt = (dictionary["updated_at"] as? String) ?? ""
        tradeAt = (dictionary["traded_at"] as? String) ?? ""
        createdAt = (dictionary["created_at"] as? String) ?? ""
    }
}
