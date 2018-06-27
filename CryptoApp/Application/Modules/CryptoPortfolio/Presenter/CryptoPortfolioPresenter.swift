//
//  CryptoPortfolioPresenter.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles all the CryptoPortfolio view actions and events.
///
final class CryptoPortfolioPresenter: CryptoPortfolioPresenterUnion {
    
    // MARK: - Vars -
    
    /// This var contains a reference to the view, with a limited
    /// scope.
    private weak var view: CryptoPortfolioViewUnion?
    /// This var contains a reference to the protfolio net handler.
    private var portfolioNetApi: PortfolioNetAdapterActions?
    /// This var contians the database handler.
    private var portfolioDatabase: PortfolioDBActions?
    /// This var contians the user interaction state machine.
    private var userInterationStateMachine: UserInteractionStateMachineActions?
    
    // MARK: - Constructors -
    
    init(withView view: CryptoPortfolioViewUnion,
         andPortfolioNetApi portfolioNetApi: PortfolioNetAdapterActions,
         andPortfolioDBHandler portfolioDatabase: PortfolioDBActions,
         andUserInterationStateMachine userInterationStateMachine: UserInteractionStateMachineActions)
    {
        self.view = view
        self.portfolioNetApi = portfolioNetApi
        self.portfolioDatabase = portfolioDatabase
        self.userInterationStateMachine = userInterationStateMachine
    }
    
    // MARK: - Crypto Currency -
    
    /// This method loads the portfolio.
    func loadPortfolio() {
        // Check if is needed load the protfolio.
        guard let uist = userInterationStateMachine, uist.shouldReloadPortfolio else {
            return
        }
        // Show loading indicator.
        view?.lockScreen()
        // If internet is available it must load form intenert.
        if Internet.isInternetAvailable() {
            // Load from net.
            portfolioNetApi?.loadPortfolio(successCallback: { coins in
                let listOfCoins = coins.map({ model -> CoinPortfolioEntity in
                    return CoinPortfolioEntity(withModel: model)
                })
                // Show the items.
                self.view?.showPortfolioItems(withItems: listOfCoins)
                // TODO: Resync database with the data that comes from server.
                // Backend limitation, it does not return the necessary data.
                
                // Remove loading indicator.
                self.view?.unlockScreen()
            }, errorCallback: { error in
                self.view?.showErrorOnLoading()
                return
            })
        } else {
            // If the portfolion database handler is nil it must break the scope.
            guard portfolioDatabase != nil else { return }
            // Load all the trades.
            let coinPortfolioItems: [CoinPortfolioEntity] = portfolioDatabase!.loadAllCoins().map(
            { dbModel -> CoinPortfolioEntity in
                return CoinPortfolioEntity(withDBModel: dbModel)
            })
            // Render the data.
            self.view?.showPortfolioItems(
                withItems: matchCoins(withPortfolioCoins: coinPortfolioItems))
            // Remove loading indicator.
            self.view?.unlockScreen()
        }
        uist.shouldReloadPortfolio = false
    }
    
    // MARK: - Private Methods -
    
    /// This method matches between all the coins in the database in order to
    /// have just only one coin type.
    ///
    /// - parameter withPorfolioCoins: List of coins to order.
    ///
    private func matchCoins(withPortfolioCoins coinPortfolioItems: [CoinPortfolioEntity])
        -> [CoinPortfolioEntity] {
        // Calculate last values.
        var portfolioMatch: [CoinPortfolioEntity] = []
        var finded: Bool = false
        
        for coin in coinPortfolioItems {
            for (index, matchCoin) in portfolioMatch.enumerated() {
                if matchCoin.id == coin.id {
                    var newValue: CoinPortfolioEntity = matchCoin
                    newValue.amount = (newValue.amount ?? 0) + (coin.amount ?? 0)
                    newValue.priceUSD = (newValue.priceUSD ?? 0) + (coin.priceUSD ?? 0)
                    portfolioMatch[index] = newValue
                    finded = true
                    break
                }
            }
            if !finded { portfolioMatch.append(coin) }
            finded = false
        }
            
        return portfolioMatch
    }
}

