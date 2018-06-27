//
//  CoinHistoricalModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

struct CoinHistoricalModel {
    var priceUDS: String?
    var snapshot: String?
    
    init(withDictionary dictionary: [String: Any]) {
        priceUDS = (dictionary["price_usd"] as? String) ?? ""
        snapshot = (dictionary["snapshot_at"] as? String) ?? ""
    }
}
