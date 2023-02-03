//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {
    
    @IBOutlet weak private var operatorInput: UILabel!
    @IBOutlet weak private var numberInput: UILabel!
    @IBOutlet weak private var calculatorItemsStackView: UIStackView!
    @IBOutlet weak private var calculatorItemsScrollView: UIScrollView!
    
    private var isFinishedCalculating: Bool = false
    private var isEnteredOperand: Bool = false
    private var isChangeableOperator: Bool = false
    private var currentNumber: String = Expression.zero {
        didSet {
            numberInput.text = applyDecimalPoint(number: currentNumber)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func operatorButtonTapped(_ sender: UIButton) {
        guard let senderSign = sender.currentTitle else { return }
        checkInitialCondition()
        operandIsZero()
        if isEnteredOperand == true  {
            addStackView()
            operatorInput.text = senderSign
        }
        
        if isChangeableOperator == true {
            operatorInput.text = senderSign
        }
        
        currentNumber = Expression.zero
    }
    
    @IBAction private func numberButtonTapped(_ sender: UIButton) {
        guard let number = sender.currentTitle,
              let operand = numberInput.text else { return }
        if numberInput.text == Expression.zero  {
            numberInput.text = number
        } else {
            numberInput.text = operand + number
        }
    }
    
    @IBAction private func dotButtonTapped(_ sender: UIButton) {
        guard let dot = sender.currentTitle,
              let operand = numberInput.text else { return }
        guard !operand.contains(dot) else { return }
        numberInput.text = operand + dot
    }
    
    @IBAction private func changeSignButtonTapped(_ sender: UIButton) {
        guard var currentNumber = numberInput.text,
              currentNumber != Expression.zero else { return }
        
        if let minus = currentNumber.firstIndex(of: Character(Expression.minus)) {
            currentNumber.remove(at: minus)
            numberInput.text = currentNumber
        } else {
            numberInput.text = Expression.minus + currentNumber
        }
    }
    
    @IBAction private func CEButtonTapped(_ sender: UIButton) {
        if isFinishedCalculating {
            numberInput.text = Expression.zero
        } else {
            numberInput.text = Expression.empty
        }
    }
    
    @IBAction private func ACButtonTapped(_ sender: UIButton) {
        calculatorItemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        currentNumber = Expression.zero
        operatorInput.text = Expression.blank
        isFinishedCalculating = false
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton) {
        if isFinishedCalculating == false {
            let result = calculate()
            currentNumber = result
        }
    }
    
    private func operandIsZero() {
        if !calculatorItemsStackView.subviews.isEmpty && numberInput.text == Expression.zero {
            isChangeableOperator = true
        } else {
            isChangeableOperator = false
        }
    }
    
    private func checkInitialCondition() {
        if numberInput.text == Expression.zero {
            isEnteredOperand = false
        } else {
            isEnteredOperand = true
        }
    }
    
    private func addStackView() {
        guard let operandStackLabel = numberInput.text,
              let operatorStackLabel = operatorInput.text else {  return  }
        
        let stackLabel = UILabel()
        stackLabel.text = operatorStackLabel + Expression.blank + operandStackLabel
        stackLabel.numberOfLines = 0
        stackLabel.adjustsFontForContentSizeCategory = true
        stackLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        stackLabel.textColor = .white
        calculatorItemsStackView.addArrangedSubview(stackLabel)
        setScrollView()
        
    }
    
    private func setScrollView() {
        let bottomOffset: CGPoint = CGPointMake(0, calculatorItemsScrollView.contentSize.height)
        calculatorItemsScrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    private func applyDecimalPoint(number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumSignificantDigits = 20
        guard let operand = Double(number),
              let result = numberFormatter.string(from: NSNumber(value: operand)) else { return Expression.empty }
        
        return result
    }
    
    private func calculate() -> String {
        let calculateItem = arrangeCalculateItems()
        var formula = ExpressionParser.parse(from: calculateItem)
        guard let resultValue = formula.result() else { return Expression.empty }
     
        return String(resultValue)
    }
    
    private func arrangeCalculateItems() -> String {
        addStackView()
        var calculateItems: [String] = []
        calculatorItemsStackView.arrangedSubviews.forEach { view in
            if let label = view as? UILabel {
                guard let value = label.text else { return }
                calculateItems.append(value)
            }
        }
        return calculateItems.map { $0.components(separatedBy: Expression.comma).joined() }
            .map { $0.components(separatedBy: Expression.blank).joined() }.joined(separator: Expression.empty)
    }
}
