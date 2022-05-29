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
    private let numberFormatter = NumberFormatter()
    
    private let zero: String = "0"
    private let emptyString: String = ""
    private let failedResult: String = "NaN"
    private let whiteSpace: String = " "
    
    private var userInput: String = ""
    private var userInputNumber: String = ""
    private var isNumberTapped : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        operandLabel.text = zero
        operatorLabel.text = emptyString
    }
    
    @IBAction private func didNumberButtonTapped(_ sender: UIButton) {
        guard let digit = sender.currentTitle else{ return }
        guard let currentOperandText = operandLabel.text else { return }
        
        initiateCaculator()
        
        if isNumberTapped  {
            operandLabel.text = (operandLabel.text ?? emptyString) + digit
        }
        else if currentOperandText.contains(".") {
            operandLabel.text = (operandLabel.text ?? emptyString) + digit
            isNumberTapped  = true
        } else {
            operandLabel.text = digit
        }
        
        makeValidNumber()
        isNumberTapped  = true
        userInputNumber.append(digit)
    }
    
    func makeValidNumber() {
        guard let currentOperandText = operandLabel.text else { return }
 
        if currentOperandText.contains(",") {
            operandLabel.text = (operandLabel.text ?? emptyString).replacingOccurrences(of: ",", with: emptyString)
        }
        
        if currentOperandText.contains(".") == false {
            let userInputNumber = makeDouble(number: (operandLabel.text ?? emptyString))
            
            guard let validNumber = userInputNumber else { return }
            
            let number = doNumberFormatter(number: validNumber)
            
            operandLabel.text = number
        }
    }
    
    func initiateCaculator() {
        guard let currentOperandText = operandLabel.text else { return }
        
        if inputStackView.subviews.isEmpty == false, currentOperandText.isEmpty {
            removeStack()
            operandLabel.text = emptyString
            userInputNumber = emptyString
        }
        
        if operandLabel.text == failedResult {
            removeStack()
            operandLabel.text = emptyString
            userInputNumber = emptyString
        }
    }
    
    @IBAction private func didDotButtonTapped(_ sender: UIButton) {
        guard let dot = sender.currentTitle else { return }
        guard let currentOperandText = operandLabel.text else { return }
        guard currentOperandText.contains(Character(dot)) == false else { return }
        
        if operandLabel.text == zero {
            operandLabel.text = "0."
            userInputNumber.append(contentsOf: zero)
            isNumberTapped  = true
        } else {
            operandLabel.text = (operandLabel.text ?? emptyString) + dot
        }
        
        userInputNumber.append(dot)
    }
    
    @IBAction private func didOperatorButtonTapped(_ sender: UIButton) {
        guard let operators = sender.currentTitle else { return }
        
        guard let lastCharacter = userInputNumber.last else { return }
        guard let _ = Double(String(lastCharacter)) else { return }
        
        addInputStack()
        operatorLabel.text = operators
        operandLabel.text = zero
        isNumberTapped  = false
        userInput.append(contentsOf: userInputNumber)
        userInput.append(contentsOf: whiteSpace)
        userInput.append(operators)
        userInput.append(contentsOf: whiteSpace)
        userInputNumber = emptyString
    }
    
    @IBAction private func didPlusMinusSignButtonTapped(_ sender: UIButton) {
        guard let currentOperandText = operandLabel.text else { return }
        
        if operandLabel.text == zero {
            return
        }
        
        if currentOperandText.hasPrefix("-") {
            operandLabel.text = String((operandLabel.text ?? emptyString).dropFirst())
            userInputNumber = String(userInputNumber.dropFirst())
        } else {
            operandLabel.text = "-" + currentOperandText
            userInputNumber = "-" + userInputNumber
        }
    }
    
    @IBAction private func didremoveAllButtonTapped(_ sender: UIButton) {
        userInput = emptyString
        userInputNumber = emptyString
        setupViews()
        removeStack()
        isNumberTapped  = false
    }
    
    @IBAction private func didremoveCurrentNumberButtonTapped(_ sender: UIButton) {
        operandLabel.text = zero
        userInputNumber = emptyString
        isNumberTapped  = false
    }
    
    @IBAction private func didCalculateButtonTapped(_ sender: UIButton) {
        if operatorLabel.text == emptyString {
            return
        }
        
        addInputStack()
        operatorLabel.text = emptyString
        userInput.append(userInputNumber)
        do {
            var result = ExpressionParser.parse(from: userInput)
            var number = doNumberFormatter(number: try result.result())
            
            if number == "-0" {
                number = zero
            }
            
            operandLabel.text = number
            userInput = emptyString
            userInputNumber = number.replacingOccurrences(of: ",", with: "")
        } catch OperatorError.divideZero {
            operandLabel.text = failedResult
            userInput = emptyString
        } catch OperatorError.wrongFormula {
            operandLabel.text = failedResult
            userInput = emptyString
        } catch {
            return
        }
    }
    
    private func generateStackLabels() -> (UILabel, UILabel)? {
        let validNumber = (operandLabel.text ?? emptyString).replacingOccurrences(of: ",", with: emptyString)
        
        guard let doubleNumber = Double(validNumber) else { return nil }
        let number = doNumberFormatter(number: doubleNumber)
        
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
    
    private func makeDouble(number: String) -> Double? {
        guard let validNumber = Double(number) else { return nil }
        return validNumber
    }
    
    private func doNumberFormatter(number:Double) -> String {
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 20
        numberFormatter.maximumIntegerDigits = 20
        
        guard let formattedNumber = numberFormatter.string(from: number as NSNumber) else {
            return failedResult
        }
        return formattedNumber
    }
}

