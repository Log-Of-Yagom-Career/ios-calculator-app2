//
//  Calculator - ViewController.swift
//  Created by DuDu
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private var calculateLogStackView: UIStackView!
    
    @IBOutlet private var currentOperator: UILabel!
    @IBOutlet private var currentOperand: UILabel!
    
    @IBOutlet private var oneZeroButton: UIButton!
    @IBOutlet private var twoZeroButton: UIButton!
    @IBOutlet private var oneButton: UIButton!
    @IBOutlet private var twoButton: UIButton!
    @IBOutlet private var threeButton: UIButton!
    @IBOutlet private var fourButton: UIButton!
    @IBOutlet private var fiveButton: UIButton!
    @IBOutlet private var sixButton: UIButton!
    @IBOutlet private var sevenButton: UIButton!
    @IBOutlet private var eightButton: UIButton!
    @IBOutlet private var nineButton: UIButton!
    
    @IBOutlet private var plusButton: UIButton!
    @IBOutlet private var minusButton: UIButton!
    @IBOutlet private var multiplyButton: UIButton!
    @IBOutlet private var divideButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func numberButtonDidTapped(_ sender: UIButton) {
        
    }
    
    @IBAction private func operatorButtonDidTapped(_ sender: UIButton) {
    }
    
    @IBAction private func dotButtonDidTapped(_ sender: Any) {
    }
    @IBAction private func acButtonDidTapped(_ sender: Any) {
    }
    @IBAction private func ceButtonDidTapped(_ sender: Any) {
    }
    @IBAction private func signButtonDidTapped(_ sender: Any) {
    }
    @IBAction private func calculateButtonDidTapped(_ sender: Any) {
    }
    
    private func findNumber(of button: UIButton) -> String {
        switch button {
        case oneZeroButton:
            return "0"
        case twoZeroButton:
            return "00"
        case oneButton:
            return "1"
        case twoButton:
            return "2"
        case threeButton:
            return "3"
        case fourButton:
            return "4"
        case fiveButton:
            return "5"
        case sixButton:
            return "6"
        case sevenButton:
            return "7"
        case eightButton:
            return "8"
        case nineButton:
            return "9"
        default:
            return ""
        }
    }
    
    private func findOperator(of button: UIButton) -> String? {
        switch button {
        case plusButton:
            return "+"
        case minusButton:
            return "-"
        case multiplyButton:
            return "×"
        case divideButton:
            return "÷"
        default:
            return ""
        }
    }
    
}

