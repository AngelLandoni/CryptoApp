//
//  CryptoPortfolioInjector.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles all the componets allocation.
///
final class CryptoPortfolioInjector: CryptoPortfolioInjectorBehaviors {
    /// This method generates the presenter.
    ///
    /// - returns: The portfolio presenter.
    ///
    func getPresenter(withView view: CryptoPortfolioViewUnion) -> CryptoPortfolioPresenterUnion {
        return CryptoPortfolioPresenter(
            withView: view,
            andPortfolioNetApi: PortfolioNetAdapter(),
            andPortfolioDBHandler: PortfolioDB(),
            andUserInterationStateMachine: UserInteractionStateMachine.shared
        )
    }

    /// This method generates the table handler.
    ///
    /// - returns: A portfolio table handler.
    ///
    func getTableHander() -> PortfolioTableHandler {
        return CryptoPortfolioViewTableHandler(withDrawer: CryptoCurrencyCellDrawer()) }
}
