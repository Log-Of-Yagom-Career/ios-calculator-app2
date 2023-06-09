//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputNumberLabel: UILabel!
    @IBOutlet weak var inputOperatorLabel: UILabel!
    @IBOutlet weak var allStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    private var resultString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputNumberLabel.text = "0"
        inputOperatorLabel.text = ""
        
    @IBAction func tapNumbersButton(_ sender: UIButton) {
        guard let inputNumber = sender.titleLabel?.text,
              let numberLabel = inputNumberLabel.text else { return }
        
        inputNumberLabel.text = (numberLabel == "0") ? (inputNumber) : (numberLabel + inputNumber)
    }
    
    }


}

