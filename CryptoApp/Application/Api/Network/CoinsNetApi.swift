//
//  CoinsNetApi.swift
//  CryptoApp
//
//  Created by Angel Landoni on 25/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import Moya

// MARK: - Structure

///
/// This enum handles all the coin requests.
///
private enum CoinNetApi {
    /// This case loads a coin page.
    case load(page: Int)
    case loadDetails(id: Int)
    case loadHistory(id: Int)
}

extension CoinNetApi: TargetType {

    var baseURL: URL { return URL(string: NetworkConstants.basetpath)! }
    
    var path: String { switch self {
        case .load(_): return "/coins"
        case .loadDetails(let id): return "/coins/\(id)"
        case .loadHistory(let id): return "/coins/\(id)/historical"
    }}
    
    var method: Method { switch self {
        case .load(_): return .get
        case .loadDetails(_): return .get
        case .loadHistory(_): return .get
    }}
    
    var sampleData: Data { return Data() }
    
    var task: Task { switch self {
        case .load(let page):
            return Task.requestParameters(parameters: ["page": page],
                                          encoding: JSONEncoding.default)
        case .loadDetails(_):
            return Task.requestPlain
        case .loadHistory(_):
            return Task.requestPlain
    }}
    
    var headers: [String : String]? { return nil }
    
    var parameterEncoding: ParameterEncoding { return JSONEncoding.default }
}

// MARJ: - Protocol

///
/// This protocol contains the basic abrstraciton of the class.
/// Methods exposed.
///
protocol CoinNetAdapterActions: class {
    func requestCoins(withPage: Int,
                      successCallback: @escaping ([CoinModel]) -> Void,
                      errorCallback: @escaping (Swift.Error) -> Void)
    func requestCoinDetail(withId id: Int,
                           successCallback: @escaping (CoinModel) -> Void,
                           errorCallback: @escaping (Swift.Error) -> Void)
    func requestCoinHistorical(withId id: Int,
                           successCallback: @escaping ([CoinHistoricalModel]) -> Void,
                           errorCallback: @escaping (Swift.Error) -> Void)
}

// MARK: - Adapter

///
/// This class contains all the coins net logic.
///
final class CoinNetAdapter: CoinNetAdapterActions {
    /// This method loads all the coins based on a page.
    ///
    /// - parameter withPage: Index of the page to load.
    /// - parameter succuessCallback: Callback used if the response is success (returns a list of coinsModels).
    /// - parameter errorCallback: Callback used if the response is failure.
    ///
    func requestCoins(withPage page: Int,
                      successCallback: @escaping ([CoinModel]) -> Void,
                      errorCallback: @escaping (Swift.Error) -> Void) {
        MoyaProvider<CoinNetApi>().request(.load(page: page)) { result in
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
                    let jsonCoinsDictionary: [String: Any] =
                        jsonDictionary["coins"] as? [String: Any] ?? [String: Any]()
                    // Unwrape the data.
                    let jsonCoinsDataDictionary: [[String: Any]] =
                        jsonCoinsDictionary["data"] as? [[String: Any]] ?? [[String: Any]]()
                    // Map the array.
                    successCallback(jsonCoinsDataDictionary.map({ (item) -> CoinModel in
                        return CoinModel(withDictionary: item)
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
    
    /// This method loads the coin deltas.
    ///
    /// - parameter withId: Id of the coin to load.
    /// - parameter succuessCallback: Callback used if the response is success (returns a coinModel).
    /// - parameter errorCallback: Callback used if the response is failure.
    ///
    func requestCoinDetail(withId id: Int,
                      successCallback: @escaping (CoinModel) -> Void,
                      errorCallback: @escaping (Swift.Error) -> Void) {
        MoyaProvider<CoinNetApi>().request(.loadDetails(id: id)) { result in
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
                    let jsonCoinDictionary: [String: Any] =
                        jsonDictionary["coin"] as? [String: Any] ?? [String: Any]()
                    // Map the array.
                    successCallback(CoinModel(withDictionary: jsonCoinDictionary))
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
    
    /// This method load the historial of the coin (price).
    ///
    /// - parameter withId: Id of the coin to load.
    /// - parameter succuessCallback: Callback used if the response is success (returns a list of CoinHistoricalModel).
    /// - parameter errorCallback: Callback used if the response is failure.
    ///
    func requestCoinHistorical(withId id: Int,
                               successCallback: @escaping ([CoinHistoricalModel]) -> Void,
                               errorCallback: @escaping (Swift.Error) -> Void) {
        MoyaProvider<CoinNetApi>().request(.loadHistory(id: id)) { result in
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
                    let jsonCoinHistoricalDictionary: [[String: Any]] =
                        jsonDictionary["historical"] as? [[String: Any]] ?? [[String: Any]]()
                    // Map the array.
                    successCallback(jsonCoinHistoricalDictionary.map(
                    { point -> CoinHistoricalModel in
                        return CoinHistoricalModel(withDictionary: point)
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
}
