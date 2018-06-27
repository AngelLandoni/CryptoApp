//
//  CryptoDetailViewActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoDetailViewActions: class {
    func update(withCoinDetail: CoinDetailEntity)
    func updateChart(withEntities: [CoinHistoricalEntity])
    
    func showBoughtAlert()
    
    func lockScreen()
    func unlockScreen()

    func showErrorOnLoading()
    func showErrorOnBuyCoin()
}
