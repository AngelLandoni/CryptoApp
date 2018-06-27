//
//  CryptoPortfolioViewTableHandlerActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This protocol contains an aftraction of methods.
///
protocol CryptoPortfolioViewTableHandlerActions: class {
    func registreCells(inTableView tableView: UITableView)
    func setNewPortfolioItems(withItems: [CoinPortfolioEntity])
}
