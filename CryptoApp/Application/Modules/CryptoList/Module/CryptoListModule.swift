//
//  CryptoListModule.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This enum contains all the posible ways to create a module.
///
enum CryptoListModule {
    /// This method generates a basic Crypto list module.
    ///
    /// - retunrs: The view of the generated module.
    ///
    static func generateCryptoList() -> UIViewController {
        let injector: CryptoListInjector = CryptoListInjector()
        let view: CryptoListView = CryptoListView(withInjector: injector)
        return view
    }
}
