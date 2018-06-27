//
//  CryptoDetailModule.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This enum contains all the posible ways to create a module.
///
enum CryptoDetailModule {
    /// This method generates a basic Crypto detail module.
    ///
    /// - retunrs: The view of the generated module.
    ///
    static func generateCryptoDetail() -> CryptoDetailView {
        let injector: CryptoDetailInjector = CryptoDetailInjector()
        let view: CryptoDetailView = CryptoDetailView(
            nibName: "CryptoDetailView", andInjector: injector)
        return view
    }
}
