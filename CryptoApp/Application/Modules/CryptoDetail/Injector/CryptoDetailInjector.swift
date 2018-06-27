//
//  CryptoDetailInjector.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles all the componets allocation.
///
final class CryptoDetailInjector: CryptoDetailInjectorBehaviors {
    /// This method generates the presenter.
    ///
    /// - returns: The detail presenter.
    ///
    func getPresenter(withView view: CryptoDetailViewUnion,
                      andCoin coin: CoinEntity) -> CryptoDetailPresenterUnion {
        return CryptoDetailPresenter(
            withView: view,
            andCoin: coin,
            andCoinsNetApi: CoinNetAdapter(),
            andPortfolioNetApi: PortfolioNetAdapter(),
            andPortfolioDBHandler: PortfolioDB(),
            andUserInterationStateMachine: UserInteractionStateMachine.shared
        )
    }
}
