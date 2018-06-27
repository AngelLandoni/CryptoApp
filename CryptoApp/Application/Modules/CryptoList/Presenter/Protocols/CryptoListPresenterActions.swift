//
//  CryptoListPresenterActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All righ/Users/alandoni/Desktop/SyncWork/CryptoApp/CryptoApp/CryptoApp/Application/Modules/CryptoList/Presenter/Protocols/CryptoListPresenterActions.swiftts reserved.
//

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoListPresenterActions: class {
    func loadAllCryptoInformation(withPage page: Int)
    func presentDetailView(withCoin coin: CoinEntity)
    func checkNetworkState()
}
