//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Casey Liss on 13/12/16.
//  Copyright © 2016 Casey Liss. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    // MARK: ivars
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.button.rx.tap
            .scan(0) { (priorValue, _) in
                return priorValue + 1
            }
            .asDriver(onErrorJustReturn: 0)
            .map { currentCount in
                return "You have tapped that button \(currentCount) times."
            }
            .drive(self.label.rx.text)
            .addDisposableTo(disposeBag)
    }

}


