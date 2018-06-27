//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct CoinModel {
    var id: Int?
    var name: String?
    var percentChange1H: String?
    var percentChange24H: String?
    var percentChange7D: String?
    var priceBTC: String?
    var priceUSD: String?
    
    var symbol: String?
    var rank: Int?
    var totalSupply: Int?
    var updatedAt: String?
    
    init() {  }
    
    init(withDictionary dictionary: [String: Any]) {
        id = (dictionary["id"] as? Int) ?? -1
        name = (dictionary["name"] as? String) ?? ""
        percentChange1H = (dictionary["percent_change_1h"] as? String) ?? ""
        percentChange24H = (dictionary["percent_change_24h"] as? String) ?? ""
        percentChange7D = (dictionary["percent_change_7d"] as? String) ?? ""
        priceBTC = (dictionary["price_btc"] as? String) ?? ""
        priceUSD = (dictionary["price_usd"] as? String) ?? ""
        
        symbol = (dictionary["symbol"] as? String) ?? ""
        rank = (dictionary["rank"] as? Int) ?? -1
        totalSupply = (dictionary["total_supply"] as? Int) ?? -1
        updatedAt = (dictionary["updated_at"] as? String) ?? ""
    }
}
