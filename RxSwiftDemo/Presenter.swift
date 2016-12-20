//
//  Presenter.swift
//  RxSwiftDemo
//
//  Created by Casey Liss on 16/12/16.
//  Copyright © 2016 Casey Liss. All rights reserved.
//

import Foundation
import RxSwift

/// Handles the business logic for `ViewController`.
/// In this contrived example, that doesn't amount
/// to much.
struct Presenter {
    
    /// Gets an `Observable` that signals the current count.
    let count: Observable<Int>
    
    /// Creates a presenter.
    ///
    /// - Parameter eventProvider: `EventProvider` that provides
    ///                            events coming from the 
    ///                            `ViewController`
    init(eventProvider: EventProvider) {
        self.count =
            eventProvider.buttonTapped.scan(0) { (previousValue, _) in
                return previousValue + 1
            }
    }
    
}
