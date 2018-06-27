//
//  CoinHistoricalModel.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Foundation

struct CoinHistoricalEntity {
    var price: Double?
    var date: Date?
    
    init(withModel model: CoinHistoricalModel) {
        price = Double(model.priceUDS ?? "0")
        date = DateHandler.fromStringToDate(buffer: model.snapshot ?? "2016-04-14T10:44:00+0000")
    }
}
