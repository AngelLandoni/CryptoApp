//
//  CryptoListViewTableHandlerActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoListViewTableHandlerActions: class {
    func registreCells(inTableView tableView: UITableView)
    func setNewCoins(withEntities: [CoinEntity])
    func appendCoints(withEntities: [CoinEntity])
    func setHotLoad(callback: @escaping (Int) -> Void)
    func setOnTap(callback: @escaping (CoinEntity) -> Void)
}
