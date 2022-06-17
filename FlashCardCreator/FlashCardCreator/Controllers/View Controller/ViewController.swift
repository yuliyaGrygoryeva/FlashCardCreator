//
//  ViewController.swift
//  FlashCardCreator
//
//  Created by Yuliya  on 6/16/22.
//

import UIKit

// Step 1 - Declare protocol
protocol Delegate: AnyObject {
    func selected(flashCard: String)
}


class ViewController: UIViewController {
    // Step 2 ' Declare the delegate and its type. Whatever is assighned as the delegate will be the delegate will be the one to perform the protocol functionality
    
    weak var delegate: Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
