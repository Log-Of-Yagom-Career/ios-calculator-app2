//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let doubleZero = "00"
        static let zero = "0"
        static let empty = ""
        static let spacing = CGFloat(8)
        static let maximumNumber = 20
    }
    
    var stringNumbers: String = ""
    var stringOperators: String = ""
    var fullFormula: String = ""
    let numberFormatter: NumberFormatter = {
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .decimal
        numberFormatter.maximumSignificantDigits = Constants.maximumNumber
      return numberFormatter
    }()
    
    @IBOutlet weak var recentNumbersStackView: UIStackView!
    @IBOutlet weak var recentNumbersScrollView: UIScrollView!
    
    @IBOutlet weak var operandsLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetAll()
    }
    
    private func resetAll() {
        stringOperators = Constants.empty
        operatorLabel.text = stringOperators
        stringNumbers = Constants.empty
        operandsLabel.text = Constants.zero
        recentNumbersStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func makeLabel(labelText: String) -> UILabel {
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        return label
    }
    
    private func makeStackView(operatorLabel: UILabel, operandLabel: UILabel) -> UIStackView {
        let formulaStackView: UIStackView = .init(arrangedSubviews: [operatorLabel, operandLabel])
        formulaStackView.spacing = Constants.spacing
        return formulaStackView
    }
    
    private func placeScroll() {
        recentNumbersScrollView.layoutIfNeeded()
        recentNumbersScrollView.setContentOffset(CGPoint(x: CGFloat(Double.zero), y: recentNumbersScrollView.contentSize.height - recentNumbersScrollView.bounds.height), animated: false)
    }
    
    @IBAction func touchUpACButton(_ sender: UIButton) {
        resetAll()
    }
    
    @IBAction func touchUpCEButton(_ sender: UIButton) {
        stringNumbers = Constants.zero
        operandsLabel.text = stringNumbers
    }
    
    @IBAction func touchUpPositiveNegativeButton(_ sender: UIButton) {
        guard operandsLabel.text != Constants.zero else { return }
        if !stringNumbers.contains("-") {
            stringNumbers = "-\(stringNumbers)"
            operandsLabel.text = stringNumbers
        } else {
            stringNumbers.removeFirst()
            operandsLabel.text = stringNumbers
        }
    }
    
    @IBAction func touchUpOperatorsButton(_ sender: UIButton) {
        var formulaStackView = UIStackView()
        var operatorUILabel = UILabel()
        
        if fullFormula != Constants.empty {
            operatorUILabel = makeLabel(labelText: stringOperators)
        }
        
        stringOperators = sender.titleLabel?.text ?? ""
        operatorLabel.text = stringOperators
        
        let operandsUILabel = makeLabel(labelText: stringNumbers)
        fullFormula += stringNumbers + stringOperators
        stringNumbers = Constants.zero
        operandsLabel.text = stringNumbers
        
        formulaStackView = makeStackView(operatorLabel: operatorUILabel, operandLabel: operandsUILabel)
        recentNumbersStackView.addArrangedSubview(formulaStackView)
        placeScroll()
    }
    
    @IBAction func touchUpNumberButton(_ sender: UIButton) {
        guard stringNumbers.count < Constants.maximumNumber else { return }
        
        if operandsLabel.text == Constants.zero {
            stringNumbers = sender.titleLabel?.text ?? ""
            operandsLabel.text = stringNumbers
        } else {
            stringNumbers += sender.titleLabel?.text ?? ""
            let number = numberFormatter.string(for: Double(stringNumbers))
            operandsLabel.text = number
        }
    }
    
    @IBAction func touchUpDoubleZeroButton(_ sender: UIButton) {
        if operandsLabel.text != Constants.zero {
            stringNumbers += Constants.doubleZero
            operandsLabel.text = stringNumbers
        }
    }
    
    @IBAction func touchUpDotButton(_ sender: UIButton) {
        guard !stringNumbers.contains(".") else { return }
        if operandsLabel.text == Constants.zero {
            stringNumbers = Constants.zero + "."
            operandsLabel.text = stringNumbers
        } else {
            stringNumbers += "."
            operandsLabel.text = stringNumbers
        }
    }
    
    @IBAction func touchUpEqualButton(_ sender: UIButton) {
        guard operatorLabel.text != Constants.empty else { return }
        stringOperators = Constants.empty
        operatorLabel.text = stringOperators
        stringNumbers = Constants.empty
        recentNumbersStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        fullFormula += operandsLabel.text ?? ""
        operandsLabel.text = fullFormula
        
        var parsedFullFormula = ExpressionParser.parse(from: fullFormula)
        let calculatedFormula = parsedFullFormula.result()
        
        operandsLabel.text = numberFormatter.string(for: calculatedFormula)
        stringNumbers = String(calculatedFormula)
    }
}

