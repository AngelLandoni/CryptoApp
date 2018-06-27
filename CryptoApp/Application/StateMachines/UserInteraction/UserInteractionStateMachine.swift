//
//  UserInteractionStateMachine.swift
//  CryptoApp
//
//  Created by Angel Landoni on 27/06/2018.
//  Copyright © 2018 Angel Landoni. All rights reserved.
//

///
/// This class represents the user interaction state machine.
/// This class exists in order to avoid load needless data when the
/// user performs actions.
///
final class UserInteractionStateMachine: UserInteractionStateMachineActions {
    // MARK: - Vars -

    /// This var contains the portfolio load state.
    private var reloadPortfolio: Bool = true
    /// THis var continas the pointer to the static memory.
    static let shared: UserInteractionStateMachineActions = UserInteractionStateMachine()
    
    /// Hide the constructor.
    private init() {  }
    
    // MARK: - Getters and Setters -
    
    /// This Getters and Setters sets the reload portfolio flag.
    var shouldReloadPortfolio: Bool {
        set { reloadPortfolio = newValue }
        get { return reloadPortfolio }
    }
}
