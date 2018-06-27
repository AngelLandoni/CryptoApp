//
//  CryptoCurrencyCell.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This class represents the basic coin cell.
///
final class CryptoCurrencyCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var variationLabel: UILabel!
}
