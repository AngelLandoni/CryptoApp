//
//  CryptoPortfolioInjectorBehaviors.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoPortfolioInjectorBehaviors: class {
    func getPresenter(withView: CryptoPortfolioViewUnion) -> CryptoPortfolioPresenterUnion
    func getTableHander() -> PortfolioTableHandler
}
