//
//  CryptoPortfolioViewTableHandler.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

typealias PortfolioTableHandler =
    UITableViewDelegate &
    UITableViewDataSource &
    CryptoPortfolioViewTableHandlerActions

///
/// This class handles the portfolio table.
///
final class CryptoPortfolioViewTableHandler: NSObject, PortfolioTableHandler {
    // MARK: - Vars

    /// This var contains the current loaded pages.
    private var pageCounter: Int = 0
    
    /// This var contains the drawer.
    private var drawer: CryptoCurrencyCellDrawer?
    
    /// This var contains the list of coints.
    private var listOfItems: [CoinPortfolioEntity] = []

    // MARK: - Constructors
    
    init(withDrawer drawer: CryptoCurrencyCellDrawer) {
        self.drawer = drawer
    }
    
    // MARK: - Methods
    
    func registreCells(inTableView tableView: UITableView) {
        tableView.register(UINib(nibName: "CryptoCurrencyCell", bundle: nil),
                           forCellReuseIdentifier: "CryptoCurrencyCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CryptoCurrencyCell = tableView.dequeueReusableCell(
            withIdentifier: "CryptoCurrencyCell") as! CryptoCurrencyCell
        drawer?.draw(inCell: cell, withData: listOfItems[indexPath.row])
        return cell
    }
    
    /// This method updates the list of items to render.
    ///
    /// - parameter withItems: List of items to render.
    ///
    func setNewPortfolioItems(withItems items: [CoinPortfolioEntity]) { listOfItems = items }
}
