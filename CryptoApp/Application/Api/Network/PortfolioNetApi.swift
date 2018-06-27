//
//  Portfolio.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Moya

// MARK: - Structure

///
/// This enum handles all the portfolio requests.
///
private enum PortfolioNetApi {
    /// This case loads a coin page.
    case load()
    case buy(coin: CoinEntity, amount: Float, date: Date)
}

extension PortfolioNetApi: TargetType {
    
    var baseURL: URL { return URL(string: NetworkConstants.basetpath)! }
    
    var path: String { switch self {
    case .load(): return "/portfolio"
    case .buy(_, _, _): return "/portfolio"
    }}
    
    var method: Method { switch self {
    case .load(): return .get
    case .buy(_, _, _): return .post
    }}
    
    var sampleData: Data { return Data() }
    
    var task: Task { switch self {
    case .load(): return Task.requestPlain
    case .buy(let coin, let amount, let date):
        return Task.requestParameters(
            parameters: [
                "coin_id": coin.id ?? 0,
                "amount": amount,
                "price_usd": ((coin.priceUSD ?? "0.0") as NSString).floatValue,
                "traded_at": Date.ISOStringFromDate(date: date)
            ],
            encoding: JSONEncoding.default)
    }}
    
    var headers: [String : String]? {
        return [
            "Accept":"application/json",
            "Authorization": "Basic \(NetworkConstants.credentialPortfolio)"
        ]
    }
    
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
}

// MARJ: - Protocol

///
/// This protocol contains the basic abrstraciton of the class.
/// Methods exposed.
///
protocol PortfolioNetAdapterActions: class {
    func loadPortfolio(successCallback: @escaping ([CoinPortfolioModel]) -> Void,
                       errorCallback: @escaping (Swift.Error) -> Void)
    func buy(withCoin:CoinEntity,
             andAmount: Float,
             andDate: Date,
             successCallback: @escaping (TradeModel) -> Void,
             errorCallback: @escaping (Swift.Error) -> Void)
}

// MARK: - Adapter

///
/// This class contains all the portfolio net logic.
///
final class PortfolioNetAdapter: PortfolioNetAdapterActions {
    /// This method loads all the coins that the user has in the portfolio.
    ///
    /// - parameter succuessCallback: Callback used if the response is success.
    /// - parameter errorCallback: Callback used if the response is failure.
    ///
    func loadPortfolio(successCallback: @escaping ([CoinPortfolioModel]) -> Void,
                      errorCallback: @escaping (Swift.Error) -> Void) {
        
        MoyaProvider<PortfolioNetApi>().request(.load()) { result in
            switch result {
            case .success(let response):
                // Check if the response has te correct status code.
                guard response.statusCode >= 200 && response.statusCode <= 300 else {
                    // Send an error.
                    errorCallback(NetworkErrorConstants.badStatusCode)
                    return
                }
                // Try to parse the json
                do {
                    let json = try response.mapJSON()
                    // Get the generay dictionary.
                    let jsonDictionary: [String: Any] =
                        json as? [String: Any] ?? [String: Any]()
                    // Unwrape the coins.
                    let jsonCoinsDictionary: [[String: Any]] =
                        jsonDictionary["coins"] as? [[String: Any]] ?? [[String: Any]]()
                    // Map the array.
                    successCallback(jsonCoinsDictionary.map({ (item) -> CoinPortfolioModel in
                        return CoinPortfolioModel(withDictionary: item)
                    }))
                } catch {
                    // Send an error.
                    errorCallback(NetworkErrorConstants.badJson)
                }
            case .failure(_):
                // Send an error.
                errorCallback(NetworkErrorConstants.badRequest)
            }
        }
    }
    
    /// This method buys the coin.
    ///
    /// - parameter withCoin: Coin to buy.
    /// - parameter andAmount: Amount to buy.
    /// - parameter andDate: Current date.
    /// - parameter succuessCallback: Callback used if the response is success (returns the trade).
    /// - parameter errorCallback: Callback used if the response is failure.
    ///
    func buy(withCoin coin: CoinEntity,
             andAmount amount: Float,
             andDate date: Date,
             successCallback: @escaping (TradeModel) -> Void,
             errorCallback: @escaping (Error) -> Void) {
        // Fixit: For some reason the date must be lower thant the date in the server.
        // The dealy allows create a gap between these 2 dates.
        DispatchQueue(label: "portfolioNetApi").asyncAfter(deadline: .now() + 2) {
            MoyaProvider<PortfolioNetApi>().request(.buy(coin: coin, amount: amount, date: date)) { result in
                switch result {
                case .success(let response):
                    // Check if the response has te correct status code.
                    guard response.statusCode >= 200 && response.statusCode <= 300 else {
                        // Send an error.
                        errorCallback(NetworkErrorConstants.badStatusCode)
                        return
                    }
                    // Try to parse the json
                    do {
                        let json = try response.mapJSON()
                        // Get the generay dictionary.
                        let jsonDictionary: [String: Any] =
                            json as? [String: Any] ?? [String: Any]()
                        // Unwrape the coins.
                        let jsonTradeDictionary: [String: Any] =
                            jsonDictionary["trade"] as? [String: Any] ?? [String: Any]()
                        // Map the array.
                        successCallback(TradeModel(withDictionary: jsonTradeDictionary))
                    } catch {
                        // Send an error.
                        errorCallback(NetworkErrorConstants.badJson)
                    }
                case .failure(_):
                    // Send an error.
                    errorCallback(NetworkErrorConstants.badRequest)
                }
            }
        }
    }
}
