//
//  CryptoListPresenter.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles all the CryptoList view actions and events.
///
final class CryptoListPresenter: CryptoListPresenterUnion {
    
    // MARK: - Vars -
    
    /// This var contains a reference to the view, with a limited
    /// scope.
    private weak var view: CryptoListViewUnion?
    /// This var contains a reference to the coins net adapter api.
    private var coinsNetApi: CoinNetAdapterActions?
    
    // MARK: - Constructors -
    
    init(withView view: CryptoListViewUnion,
         andCoinsNetApi coinsNetApi: CoinNetAdapterActions)
    {
        self.view = view
        self.coinsNetApi = coinsNetApi
    }
    
    // MARK: - Crypto Currency -

    /// This method loads all the crypto currencies information.
    ///
    /// - parameter withPage: The number of page to load.
    ///
    func loadAllCryptoInformation(withPage page: Int) {
        // Call the service
        coinsNetApi?.requestCoins(withPage: page, successCallback: { coins in
            // Map all the new coins.
            self.view?.appendCoins(withEntities: coins.map({ coin -> CoinEntity in
                return CoinEntity(withModel: coin)
            }))
            self.view?.refreshTable()
        }) { error in
            self.view?.showErrorOnLoading()
        }
    }
    
    /// This method pushes the detail view.
    ///
    /// - parameter withCoin: Coin used to show the detail of it.
    ///
    func presentDetailView(withCoin coin: CoinEntity) {
        // Force to the view to push the detail view.
        view?.moveToDetailView(withCoin: coin)
    }
    
    /// This method check if internet is available and enables or disables the
    /// list fuctionality
    func checkNetworkState() {
        if Internet.isInternetAvailable() { view?.hideNoInternetMessage()
        } else { view?.showNoInternetMessage() }
    }
}

