//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorDisplayLabel: UILabel!
    @IBOutlet weak var operatorDisplayLabel: UILabel!
    @IBOutlet weak var calculatorArchive: UIStackView!

    private var displayLabelText: String = nameSpace.zero {
        didSet{
            calculatorDisplayLabel.text = displayLabelText
        }
    }
    
    private(set) var formula: String = nameSpace.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIndentifier()
    }
    
    func setAccessibilityIndentifier() {
        calculatorDisplayLabel.isAccessibilityElement = true
        calculatorDisplayLabel.accessibilityIdentifier = accessibilityIdentifier.calculatorDisplayLabel
        
        operatorDisplayLabel.isAccessibilityElement = true
        operatorDisplayLabel.accessibilityIdentifier = accessibilityIdentifier.operatorDisplayLabel
        
        calculatorArchive.isAccessibilityElement = true
        calculatorArchive.accessibilityIdentifier = accessibilityIdentifier.calculatorArchive
    }

    @IBAction func numberButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        
        if displayLabelText == nameSpace.zero {
            displayLabelText = title
        } else {
            displayLabelText = displayLabelText + title
        }
    }
    
    @IBAction func zeroButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        
        if displayLabelText != nameSpace.zero {
            displayLabelText = displayLabelText + title
        }
    }
    
    @IBAction func dotButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        
        displayLabelText = displayLabelText + title
    }
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle,
              let operatorText = operatorDisplayLabel.text else {
            return
        }
        
        if displayLabelText != nameSpace.zero {
            pushInFormula(operand: displayLabelText, operator: operatorText)
            pushInArchive(operand: displayLabelText, operator: operatorText)
        }
        
        if formula.isEmpty == false {
            operatorDisplayLabel.text = title
        }
        
        displayLabelText = nameSpace.zero
    }
    
    func pushInFormula(operand: String, `operator`: String) {
        if self.formula.isEmpty {
            formula += operand
        } else {
            formula += `operator` + operand
        }
    }
    
    func pushInArchive(operand: String, `operator`: String) {
        let stackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            return stackView
        }()
        
        let operatorLabel = {
            let label = UILabel()
            label.text = `operator`
            label.textColor = .white
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            
            return label
        }()
        
        let operandLabel = {
            let label = UILabel()
            label.text = operand
            label.textColor = .white
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            
            return label
        }()
        
        stackView.addArrangedSubview(operatorLabel)
        stackView.addArrangedSubview(operandLabel)
        calculatorArchive.addArrangedSubview(stackView)
    }
    
    @IBAction func changeSignButtonTapped(_ sender: UIButton) {
        if displayLabelText != nameSpace.zero {
            displayLabelText = changeSign(displayLabelText)
        }
    }
    
    func changeSign(_ text: String) -> String {
        if text.first == Character(nameSpace.negative) {
            let secondIndex = text.index(after: text.startIndex)
            return String(text[secondIndex...])
        } else {
            return nameSpace.negative + text
        }
    }
    
    @IBAction func clearEntryButtonTapped(_ sender: UIButton) {
        displayLabelText = nameSpace.zero
    }
    
    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        displayLabelText = nameSpace.zero
        operatorDisplayLabel.text = nameSpace.empty
        formula = nameSpace.empty
        
        allClearArchive()
    }
    
    func allClearArchive() {
        calculatorArchive.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let operatorText = operatorDisplayLabel.text else {
            return
        }
        
        pushInFormula(operand: displayLabelText, operator: operatorText)
        pushInArchive(operand: displayLabelText, operator: operatorText)
        
        var parsedFormula = ExpressionParser.parse(from: formula)
        
        do {
            let result = try parsedFormula.result()
            displayLabelText = String(result)
        } catch CalculatorError.divideZero {
            displayLabelText = nameSpace.nan
        } catch {
            print(error.localizedDescription)
        }
        
        formula = nameSpace.empty
        operatorDisplayLabel.text = nameSpace.empty
        
        trimmingDoubleToInt(string: displayLabelText)
    }
    
    func trimmingDoubleToInt(string: String) {
        guard let textToDouble = Double(displayLabelText) else {
            return
        }
        
        if Double(Int(textToDouble)) == textToDouble {
            displayLabelText = String(Int(textToDouble))
        }
    }
}

