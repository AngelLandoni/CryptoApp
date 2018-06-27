//
//  CryptoListInjector.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles all the componets allocation.
///
final class CryptoListInjector: CryptoListInjectorBehaviors {
    /// This method generates the presenter.
    ///
    /// - returns: The crypto list presenter.
    ///
    func getPresenter(withView view: CryptoListViewUnion) -> CryptoListPresenterUnion {
        return CryptoListPresenter(
            withView: view,
            andCoinsNetApi: CoinNetAdapter()
        )
    }

    /// This method generates the table handler.
    ///
    /// - returns: A crypto list table handler.
    ///
    func getTableHander() -> TableHandler {
        return CryptoListViewTableHandler(withDrawer: CryptoCurrencyCellDrawer()) }
}
