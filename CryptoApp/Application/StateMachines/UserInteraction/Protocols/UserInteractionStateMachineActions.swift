//
//  UserInteractionStateMachineActions.swift
//  CryptoApp
//
//  Created by Angel Landoni on 27/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This protocol contains all the actions needed to handle the
/// user interaction state machine.
///
protocol UserInteractionStateMachineActions: class {
    var shouldReloadPortfolio: Bool { get set }
}
