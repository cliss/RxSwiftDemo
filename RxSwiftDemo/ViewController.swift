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
    private var count = 0
    
    override func viewDidLoad() {
        self.button.rx.tap
            .debug("button tap")
            .subscribe(onNext: { [unowned self] _ in
                self.onButtonTap()
            }).addDisposableTo(disposeBag)
    }
    
    @IBAction private func onButtonTap() {
        self.count += 1
        self.label.text = "You have tapped that button \(count) times."
    }


}


