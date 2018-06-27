//
//  CryptoDetailPresenter.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Foundation

///
/// This class handles all the CryptoList view actions and events.
///
final class CryptoDetailPresenter: CryptoDetailPresenterUnion {
    
    // MARK: - Vars -
    
    /// This var contains a reference to the view, with a limited
    /// scope.
    private weak var view: CryptoDetailViewUnion?
    /// This var contains a reference to the protfolio net handler.
    private var portfolioNetApi: PortfolioNetAdapterActions?
    /// This var contains a reference to the coins net adapter api.
    private var coinsNetApi: CoinNetAdapterActions?
    /// This var contains the selected coin.
    private var coin: CoinEntity?
    /// This var contians the database handler.
    private var portfolioDatabase: PortfolioDBActions?
    /// This var contians the user interaction state machine.
    private var userInterationStateMachine: UserInteractionStateMachineActions?
    
    // MARK: - Constructors -
    
    init(withView view: CryptoDetailViewUnion,
         andCoin coin: CoinEntity,
         andCoinsNetApi coinsNetApi: CoinNetAdapterActions,
         andPortfolioNetApi portfolioNetApi: PortfolioNetAdapterActions,
         andPortfolioDBHandler portfolioDatabase: PortfolioDBActions,
         andUserInterationStateMachine userInterationStateMachine: UserInteractionStateMachineActions)
    {
        self.view = view
        self.coin = coin
        self.coinsNetApi = coinsNetApi
        self.portfolioNetApi = portfolioNetApi
        self.portfolioDatabase = portfolioDatabase
        self.userInterationStateMachine = userInterationStateMachine
    }
    
    // MARK: - Actions -
    
    /// This method load the details.
    func loadDetails() {
        // Loads the coin informatio.
        coinsNetApi?.requestCoinDetail(
        withId: coin?.id ?? 1, successCallback: { coin in
            self.view?.update(withCoinDetail: CoinDetailEntity(withModel: coin))
        }, errorCallback: { error in
            self.view?.showErrorOnLoading()
        })
    }
    
    /// This method loads the coin's historical.
    func loadHistorical() {
        coinsNetApi?.requestCoinHistorical(
        withId: coin?.id ?? 1, successCallback: { historical in
            self.view?.updateChart(withEntities: historical.map(
            { coinHistoryPoint -> CoinHistoricalEntity in
                return CoinHistoricalEntity(withModel: coinHistoryPoint)
            }))
        }, errorCallback: { (error) in
            self.view?.showErrorOnLoading()
        })
    }
    
    /// This method buys the coin.
    ///
    /// - parameter withAmount: The number of coins to buy.
    ///
    func buyCoin(withAmount amount: Float) {
        guard coin != nil else { return }
        // Lock screen until the server response.
        view?.lockScreen()
        // Buy a new coin.
        portfolioNetApi?.buy(withCoin: coin!,
                             andAmount: amount,
                             andDate: Date(), successCallback: { trade in
            // Save the coin in database.
            self.portfolioDatabase?.saveCoin(
                withModel: PortfolioItemDBModel(withTrade: TradeEntity(withModel: trade)))
            // Shown a positive alert.
            self.view?.unlockScreen()
            self.view?.showBoughtAlert()
            // Update user actions.
            self.userInterationStateMachine?.shouldReloadPortfolio = true
        }, errorCallback: { error in
            self.view?.unlockScreen()
            self.view?.showErrorOnBuyCoin()
        })
    }
}
