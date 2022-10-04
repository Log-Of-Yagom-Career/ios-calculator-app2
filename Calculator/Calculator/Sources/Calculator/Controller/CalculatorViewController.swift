//
//  Calculator - CalculatorViewController.swift
//  Created by 미니.
//

import UIKit

final class CalculatorViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var recordedCalculatedStackView: UIStackView!
    @IBOutlet private weak var currentNumbersLabel: UILabel!
    @IBOutlet private weak var currentOperatorLabel: UILabel!
    
    private var mathExpression: String = ""
    private var selectedNumbers: String = ""
    private var selectedOperator: String = ""
    private var didNotCalculate: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitState()
    }
    
    @IBAction func didTappedNumberButton(_ sender: UIButton) {
        guard didNotCalculate,
              let inputNumber = sender.titleLabel?.text else {
            return
        }
        
        if let lastElement = mathExpression.last,
           !lastElement.shouldConvertOperator {
            mathExpression.append(selectedOperator)
        }

        selectedNumbers.append(inputNumber)
        
        if selectedNumbers.contains(Constant.Calculator.defaultPoint) {
            updateNumberLabelTo(numbers: selectedNumbers)
        } else {
            updateNumberLabelTo(numbers: selectedNumbers.toFormattedString()!)
        }
    }
    
    @IBAction func didTappedOperatorButton(_ sender: UIButton) {
        guard didNotCalculate,
              let inputedOperator = sender.titleLabel?.text else {
            return
        }
        
        if selectedNumbers.isNotEmpty {
            addLogStackView()
        }
        
        mathExpression.append(selectedNumbers)
        resetSelectedNumbers()
        
        selectedOperator = inputedOperator
        
        updateOperatorLabel()
        resetNumberLabel()
    }
    
    @IBAction func didTappedEqualButton(_ sender: UIButton) {
        
        guard didNotCalculate,
              selectedNumbers.isNotEmpty else {
            return
        }
        
        guard let lastElement = mathExpression.last else {
            resetSelected()
            return
        }
        
        addLogStackView()
        
        if !lastElement.shouldConvertOperator {
            mathExpression.append(selectedOperator)
        }

        mathExpression.append(selectedNumbers)
        
        calculateExpression()
        
        didNotCalculate.toggle()
    }
    
    @IBAction func didTappedACButton(_ sender: UIButton) { resetInitState() }
    
    @IBAction func didTappedCEButton(_ sender: UIButton) {
        guard didNotCalculate else {
            resetInitState()
            return
        }
        
        resetSelectedNumbers()
        resetNumberLabel()
    }
    
    @IBAction func didTappedPointButton(_ sender: UIButton) {
        
        guard selectedNumbers.isNotEmpty,
              !selectedNumbers.contains(Constant.Calculator.defaultPoint) else {
            return
        }
        
        selectedNumbers.append(Constant.Calculator.defaultPoint)
        updateNumberLabelTo(numbers: selectedNumbers)
    }
    
    
    @IBAction func didTappedConvertSign(_ sender: UIButton) {
        guard selectedNumbers.isNotEmpty,
              let firstElement = selectedNumbers.first else {
            return
        }
        
        if firstElement == Constant.Calculator.minusOperator {
            selectedNumbers.removeFirst()
        } else {
            selectedNumbers.insert(
                Constant.Calculator.minusOperator,
                at: selectedNumbers.startIndex
            )
        }
        
        updateNumberLabelTo(numbers: selectedNumbers.toFormattedString())
    }
}

// MARK: - StackView UI변경 관련 메서드
private extension CalculatorViewController {
    func addLogStackView() {
        let operatorValue = selectedOperator.isEmpty ? Constant.Calculator.defaultInput : selectedOperator
        
        let childView = CalculatedLogStackView(
            operatorValue: operatorValue,
            operandValue: selectedNumbers.toFormattedString()
        )
        
        recordedCalculatedStackView.addArrangedSubview(childView)
        scrollView.scrollToBottom(animated: true)
    }
    
    func removeAllLogStackView() {
        recordedCalculatedStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}

// MARK: - 계산기 사용자 입력 상태 관리 메서드
private extension CalculatorViewController {
    func setUpInitState() {
        currentNumbersLabel.text = Constant.Calculator.defaultNumber
        currentOperatorLabel.text = Constant.Calculator.defaultOperator
    }
    
    func resetInitState() {
        resetLabels()
        resetSelected()
        resetMathExpression()
        removeAllLogStackView()
        didNotCalculate = true
    }

    func resetSelected() {
        resetSelectedNumbers()
        resetSelectedOperator()
    }
    
    func resetSelectedNumbers() {
        selectedNumbers = Constant.Calculator.defaultInput
    }
    
    func resetSelectedOperator() {
        selectedOperator = Constant.Calculator.defaultInput
    }
    
    func resetMathExpression() {
        mathExpression = Constant.Calculator.defaultInput
    }
    
    func calculateExpression() {
        var formula = ExpressionParser.parse(from: mathExpression)

            let calculatedValue = formula.result()
            let calNumber = calculatedValue?.description.toFormattedString()

            updateNumberLabelTo(numbers: calNumber)
            resetOperatorLabel()

            resetSelected()

    }
}

// MARK: - 뷰 관련 메서드
private extension CalculatorViewController {
    func resetLabels() {
        resetNumberLabel()
        resetOperatorLabel()
    }

    func resetNumberLabel() {
        currentNumbersLabel.text = Constant.Calculator.defaultNumber
    }
    
    func resetOperatorLabel() {
        currentOperatorLabel.text = Constant.Calculator.defaultOperator
    }
    
    func updateNumberLabelTo(numbers: String?) {
        currentNumbersLabel.text = numbers
    }
    
    func updateOperatorLabel() {
        currentOperatorLabel.text = selectedOperator
    }
    
}

// MARK: - Character Extension 관련 메서드
private extension Character {
    var shouldConvertOperator: Bool {
        return Operator(rawValue: self) != nil
    }
}

// MARK: - String Extension 관련 메서드
private extension String {
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
}
