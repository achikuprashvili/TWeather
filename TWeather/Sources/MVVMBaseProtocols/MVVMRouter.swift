//
//  MVVMRouter.swift
//  TWeather
//
//  Created by Archil on 3/16/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

/// The protocol for the router in MVVM+Router architecture
protocol MVVMRouter {
    
    /// The view controller which is used to present the current one
    /// Make it WEAK
    var baseViewController: UIViewController? { get }
    
    /// This method should be used as an entry point for presenting the VC for particular router
    ///
    /// - Parameters:
    ///   - baseVC: the base VC
    ///   - animated: animated presenting or not
    ///   - context: optional context
    ///   - completion: the closure to be invoked in the end of presentation with result (was presented or not)
    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
    
    /// This method should be used to present next view controller as a result some action
    ///
    /// - Parameters:
    ///   - context: the optional context which may be passed over
    ///   - animated: animated presenting or not
    ///   - completion: the closure to be invoked in the end of presentation with result (was presented or not)
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?)
    
    /// This method should be used to dismiss from base view controller
    ///
    /// - Parameters:
    ///   - animated: animated presenting or not
    ///   - context: the optional context which may be passed over
    ///   - completion: the closure to be invoked in the end of dismissing with result (was presented or not)
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
}

extension MVVMRouter {
    
    /// Convenience method to use default values for parameters, which rarely used
    func present(on baseVC: UIViewController) {
        self.present(on: baseVC, animated: true, context: nil, completion: nil)
    }
    
    /// Convenience method to use default values for parameters, which rarely used
    func enqueueRoute(with context: Any?) {
        self.enqueueRoute(with: context, animated: true, completion: nil)
    }
    
    func enqueueRoute(with context: Any?, completion: ((Bool) -> Void)?) {
        self.enqueueRoute(with: context, animated: true, completion: completion)
    }
}
