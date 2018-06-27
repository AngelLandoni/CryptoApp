//
//  CryptoPortfolioModule.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This enum contains all the posible ways to create a module.
///
enum CryptoPortfolioModule {
    /// This method generates a basic Crypto portfolio module.
    ///
    /// - retunrs: The view of the generated module.
    ///
    static func generateCryptoPortfolio() -> UIViewController {
        let injector: CryptoPortfolioInjector = CryptoPortfolioInjector()
        let view: CryptoPortfolioView = CryptoPortfolioView(withInjector: injector)
        return view
    }
}
