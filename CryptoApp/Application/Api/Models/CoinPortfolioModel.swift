//
//  CoinPortfolioModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct CoinPortfolioModel {
    var id: Int?
    var amount: Double?
    var priceUSD: Double?
    
    init(withDictionary dictionary: [String: Any]) {
        id = (dictionary["coin_id"] as? Int) ?? 0
        // Incorrect number format, it must change it in order to
        // save it.
        amount = Double(dictionary["amount"] as? String ?? "0.0")
        priceUSD = Double(dictionary["price_usd"] as? String ?? "0.0")
    }
}
