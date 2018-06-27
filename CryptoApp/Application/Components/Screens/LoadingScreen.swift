//
//  LoadingScreen.swift
//  CryptoApp
//
//  Created by Angel Landoni on 26/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

import UIKit

///
/// This class represents a loading screen.
///
final class LoadingScreen: UIView {
    
    // MARK: - Components -

    /// This var contains the spiner.
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(
        activityIndicatorStyle: .white)
    
    // MARK: - Constructors -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(withFrame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup(withFrame: UIScreen.main.bounds)
    }
    
    // MARK: - Private Methods -

    /// This method setups the entire component.
    ///
    /// - parameter withFrame: The size of the component.
    private func setup(withFrame frame: CGRect) {
        addSubview(loadingIndicator)
        loadingIndicator.startAnimating()
        // Center the indicator.
        loadingIndicator.frame.origin.x = frame.width / 2 - loadingIndicator.frame.width / 2
        loadingIndicator.frame.origin.y = frame.height / 2 - loadingIndicator.frame.height / 2
        // Setup style.
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
}
