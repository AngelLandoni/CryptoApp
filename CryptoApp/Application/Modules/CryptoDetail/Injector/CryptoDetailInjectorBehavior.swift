//
//  CryptoDetailInjectorBehavior.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoDetailInjectorBehaviors: class {
    func getPresenter(withView: CryptoDetailViewUnion,
                      andCoin coin: CoinEntity) -> CryptoDetailPresenterUnion
}
