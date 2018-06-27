//
//  Network.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

// MARK: - Constants

///
/// This enum contains the basic network constatns.
///
enum NetworkConstants {
    /// This var contains the base path for all the url requests.
    static let basetpath: String = "https://test.cryptojet.io"
    /// The var contains the user's credentials.
    /// The value should be base64(user:password)
    /// In this case the value is harcoded with the user "richard@rich.com:secret"
    static let credentialPortfolio: String = "cmljaGFyZEByaWNoLmNvbTpzZWNyZXQ="
}

// MARK: - Error Constants

///
/// This enum contains all the constants errors used in the network layer.
///
enum NetworkErrorConstants {
    /// This var contains the error when the Json has a bad structure.
    static let badJson: NSError = NSError(domain: "networkLayer",
                                          code: 0,
                                          userInfo: [NSLocalizedDescriptionKey: "Parsing json"])
    /// This var contains the error when the response contains a bad status code.
    static let badStatusCode: NSError = NSError(domain: "networkLayer",
                                                code: 1,
                                                userInfo: [NSLocalizedDescriptionKey: "Bad status code"])
    /// This var contains the error when the server responses with a bad request.
    static let badRequest : NSError = NSError(domain: "networkLayer",
                                              code: 2,
                                              userInfo: [NSLocalizedDescriptionKey: "Bad request"])
}
