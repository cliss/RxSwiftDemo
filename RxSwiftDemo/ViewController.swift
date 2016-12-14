//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Casey Liss on 13/12/16.
//  Copyright © 2016 Casey Liss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: ivars
    private var count = 0
    
    @IBAction private func onButtonTap(sender: UIControl) {
        self.count += 1
        self.label.text = "You have tapped that button \(count) times."
    }


}


