//
//  CryptoListViewActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoListViewActions: class {
    func appendCoins(withEntities: [CoinEntity])
    
    func moveToDetailView(withCoin: CoinEntity)
    
    func showNoInternetMessage()
    func hideNoInternetMessage()
    
    func refreshTable()
    
    func showErrorOnLoading()
}
