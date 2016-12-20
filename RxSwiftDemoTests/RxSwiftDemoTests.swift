//
//  RxSwiftDemoTests.swift
//  RxSwiftDemoTests
//
//  Created by Casey Liss on 13/12/16.
//  Copyright © 2016 Casey Liss. All rights reserved.
//

import XCTest
@testable import RxSwiftDemo
import RxSwift
import RxTest

class RxSwiftDemoTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    var scheduler: TestScheduler!
    
    override func setUp() {
        super.setUp()
        // Every time we run a test, create a new scheduler
        self.scheduler = TestScheduler(initialClock: 0)
        // ...and dispose bag.
        self.disposeBag = DisposeBag()
    }
    
    func testPresenterCount() {
        // Here's what the observable will signal:
        // ----[@100]---[@200]---[@300]--->
        // The unit of time isn't terribly relevant
        // as these will be run as quickly as possible.
        let buttonTaps = self.scheduler.createHotObservable([
            next(100, ()),
            next(200, ()),
            next(300, ())
        ])
        
        // An observer listens to an observable. A
        // TestableObserver (as created here) also 
        // stores the signals the observable sends. 
        // We will use this to compare to.
        let results = scheduler.createObserver(Int.self)
        
        // Wire up our actual code. Note we're using our
        // faked observable here as the button taps.
        let eventProvider = EventProvider(buttonTapped: buttonTaps.asObservable())
        let presenter = Presenter(eventProvider: eventProvider)
        
        // At time zero, wire up the observer to the observable.
        self.scheduler.scheduleAt(0) {
            presenter.count.subscribe(results).addDisposableTo(self.disposeBag)
        }
        // Start the simulation
        scheduler.start()
        
        // Here's what we expect to come out. Note the same time
        // stamps, but the results are 1, 2, 3, not the () we're
        // signaling with.
        let expected = [
            next(100, 1),
            next(200, 2),
            next(300, 3)
        ]
        
        // Compare actual to expected.
        XCTAssertEqual(results.events, expected)
        
    }
    
}
