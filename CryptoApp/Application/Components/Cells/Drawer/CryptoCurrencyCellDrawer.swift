//
//  CryptoCurrencyCellDrawer.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class handles the cell's drawing.
///
class CryptoCurrencyCellDrawer {
    /// This method draws into the cell the coin entity information.
    ///
    /// - parameter inCell: Cell to insert the data.
    /// - parameter withData: Data to render.
    ///
    func draw(inCell cell: CryptoCurrencyCell, withData data: CoinEntity) {
        cell.nameLabel?.text = data.name
        cell.priceLabel?.text = "\(data.priceUSD ?? "")"
        cell.variationLabel.text = data.percentChange1H
    }
    /// This method configures the cell with a protfolio coint.
    ///
    /// - parameter inCell: Cell to insert the data.
    /// - parameter withData: Data to render.
    ///
    func draw(inCell cell: CryptoCurrencyCell, withData data: CoinPortfolioEntity) {
        cell.nameLabel?.text = "\(data.id ?? 0)"
        cell.priceLabel?.text = "\(data.priceUSD ?? 0.0)"
        cell.variationLabel.text = "\(data.amount ?? 0.0)"
    }
}
