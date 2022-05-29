//
//  Calculator - ViewController.swift
//  Created by Kiwi. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var operandLabel: UILabel!
    
    private var userInput: String = ""
    private var userInputNumber: String = ""
    private var userNumberTapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        operandLabel.text = "0"
        operatorLabel.text = ""
    }
    
    @IBAction private func didTapNumberButton(_ sender: UIButton) {
        guard let digit = sender.currentTitle else{ return }
        
        if inputStackView.subviews.isEmpty == false, operatorLabel.text!.isEmpty {
            removeStack()
            operandLabel.text! = ""
            userInputNumber = ""
        }
        
        if operandLabel.text! == "NaN" {
            removeStack()
            operandLabel.text! = ""
            userInputNumber = ""
        }
        
        if userNumberTapped {
            operandLabel.text! += digit
        }
        else if operandLabel.text!.contains(".") {
            operandLabel.text! += digit
            userNumberTapped = true
        } else {
            operandLabel.text! = digit
        }
        
        if operandLabel.text!.contains(",") {
            operandLabel.text! = operandLabel.text!.replacingOccurrences(of: ",", with: "")
        }
        
        if operandLabel.text!.contains(".") == false {
            let validNumber = makeDouble(number: operandLabel.text!)
            let number = doNumberFormatter(number: validNumber)
            
            operandLabel.text = number
        }
        userNumberTapped = true
        userInputNumber.append(digit)
    }
    
    @IBAction private func didTapDot(_ sender: UIButton) {
        guard let dot = sender.currentTitle else { return }
        let textCurrentlyInDisply = operandLabel.text!
        
        if textCurrentlyInDisply.contains(Character(dot)) {
            return
        } else if operandLabel.text == "0" {
            operandLabel.text = "0."
            userInputNumber.append(contentsOf: "0")
            userNumberTapped = true
        } else {
            operandLabel.text! = textCurrentlyInDisply + dot
        }
        
        userInputNumber.append(dot)
    }
    
    @IBAction private func didTapOperatorButton(_ sender: UIButton) {
        guard let operators = sender.currentTitle else { return }
        
        guard let lastCharacter = userInputNumber.last else { return }
        guard let _ = Double(String(lastCharacter)) else { return }
        
        addInputStack()
        operatorLabel.text = operators
        operandLabel.text = "0"
        userNumberTapped = false
        userInput.append(contentsOf: userInputNumber)
        userInput.append(contentsOf: " ")
        userInput.append(operators)
        userInput.append(contentsOf: " ")
        userInputNumber = ""
    }
    
    @IBAction private func didTapPlusMinusSignButton(_ sender: UIButton) {
        if operandLabel.text == "0" {
            return
        }
        
        if operandLabel.text!.hasPrefix("-") {
            operandLabel.text = String(operandLabel.text!.dropFirst())
            userInputNumber = String(userInputNumber.dropFirst())
        } else {
            operandLabel.text = "-" + operandLabel.text!
            userInputNumber = "-" + userInputNumber
        }
    }
    
    @IBAction private func removeAllButton(_ sender: UIButton) {
        userInput = ""
        userInputNumber = ""
        setupViews()
        removeStack()
        userNumberTapped = false
    }
    
    @IBAction private func removeCurrentNumberButton(_ sender: UIButton) {
        operandLabel.text = "0"
        userInputNumber = ""
        userNumberTapped = false
    }
    
    @IBAction private func didTapCalculateButton(_ sender: UIButton) {
        if operatorLabel.text == "" {
            return
        }
        
        addInputStack()
        operatorLabel.text! = ""
        userInput.append(userInputNumber)
        do {
            var result = ExpressionParser.parse(from: userInput)
            var number = doNumberFormatter(number: try result.result())
            
            if number == "-0" {
                number = "0"
            }
            
            operandLabel.text = number
            userInput = ""
            userInputNumber = number.replacingOccurrences(of: ",", with: "")
        } catch OperatorError.divideZero {
            operandLabel.text = "NaN"
            userInput = ""
        } catch OperatorError.wrongFormula {
            operandLabel.text = "NaN"
            userInput = ""
        } catch {
            return
        }
    }
    
    private func generateStackLabels() -> (UILabel, UILabel)? {
        guard let validNumber = Double(operandLabel.text!) else { return nil }
        let number = doNumberFormatter(number: validNumber)
        
        guard let `operator` = operatorLabel.text else {
            return nil
        }
        
        let operatorStackLabel = UILabel()
        let numberStackLabel = UILabel()
        
        operatorStackLabel.textColor = .white
        operatorStackLabel.text = `operator`
        
        numberStackLabel.textColor = .white
        numberStackLabel.text = number
        
        return (operatorStackLabel, numberStackLabel)
    }
    
    private func generateStack() -> UIStackView? {
        guard let (operatorStackLabel, numberStackLabel) = generateStackLabels() else {
            return nil
        }
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .fill
        
        stack.addArrangedSubview(operatorStackLabel)
        stack.addArrangedSubview(numberStackLabel)
        
        return stack
    }
    
    private func addInputStack() {
        guard let stack = generateStack() else {
            return
        }
        
        inputStackView.addArrangedSubview(stack)
        scrollToBottom(scrollView)
    }
    
    private func scrollToBottom(_ scrollView: UIScrollView) {
        scrollView.layoutIfNeeded()
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.frame.height), animated: false)
    }
    
    private func removeStack() {
        inputStackView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func makeDouble(number: String) -> Double {
        guard let validNumber = Double(number) else { return 0 }
        return validNumber
    }
    
    private func doNumberFormatter(number:Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 20
        numberFormatter.maximumIntegerDigits = 20
        
        guard let formattedNumber = numberFormatter.string(from: number as NSNumber) else {
            return "NaN"
        }
        return formattedNumber
    }
}

