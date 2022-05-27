import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var operatorLable: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var currentFormula = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func convertToDecimal(_ number: Double) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        numberFormat.maximumFractionDigits = 20
        
        guard let value = numberFormat.string(from: NSNumber(value: number)) else {
            return "0"
        }
        
        return value
    }
    
    private func checkOperatorError() throws {
        guard currentFormula != "" else {
            throw CalculatorError.invalidOperatorInput
        }
        
        guard let lastInput = currentFormula.last, Operator(rawValue: lastInput) == nil else {
            throw CalculatorError.duplicatedOperator
        }
    }
    
    private func addFormulaLable(content: String) {
        let lable = UILabel()
        lable.text = content
        lable.textColor = .white
        stackView.addArrangedSubview(lable)
    }
    
    private func printFormula() {
        if Double(currentFormula) != nil {
            addFormulaLable(content: currentFormula)
            return
        }
        
        let numberCount = (numberLable.text ?? "0").filter { $0 != "," }.count
        let number = currentFormula.suffix(numberCount)
        var formula = currentFormula.dropLast(numberCount)
        let `operator` = formula.removeLast()
        
        addFormulaLable(content: String(`operator`) + " " + number)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + 20), animated: false)
    }
    
    private func deleteFormulaLable() {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
        }
    }
    
    @IBAction private func numberPadTapped(_ sender: UIButton) {
        if let lastInput = currentFormula.last, Operator(rawValue: lastInput) != nil {
            numberLable.text = "0"
        }
        
        let numberText = (numberLable.text ?? "0").filter { $0 != "," }
        
        if let buttonText = sender.titleLabel?.text, let number = Double(numberText + buttonText) {
            numberLable.text = convertToDecimal(number)
            currentFormula += buttonText
        }
    }
    
    @IBAction private func operatorPadTapped(_ sender: UIButton) {
        do {
            try checkOperatorError()
            printFormula()
            numberLable.text = "0"
        } catch {
            switch error {
            case CalculatorError.duplicatedOperator:
                currentFormula = String(currentFormula.dropLast())
            case CalculatorError.invalidOperatorInput:
                return
            default:
                return
            }
        }
        
        operatorLable.text = sender.titleLabel?.text
        currentFormula += sender.titleLabel?.text ?? ""
    }
    
    @IBAction private func equalButtonTapped(_ sender: UIButton) {
        if let lastNumber = currentFormula.last, Operator(rawValue: lastNumber) != nil {
            currentFormula += "0"
        }
        
        do {
            var formula = try ExpressionParser.parse(from: currentFormula)
            let calculatedResult = try formula.result()
            printFormula()
            numberLable.text = convertToDecimal(calculatedResult)
            currentFormula = convertToDecimal(calculatedResult).filter { $0 != ","}
        } catch {
            switch error {
            case CalculatorError.dividedByZero:
                numberLable.text = "NaN"
                currentFormula.removeAll()
            case CalculatorError.wrongFormula:
                currentFormula.removeAll()
                return
            default:
                return
            }
        }
        
        operatorLable.text = ""
    }
    
    @IBAction private func ACButtonTapped(_ sender: UIButton) {
        deleteFormulaLable()
        numberLable.text = "0"
        operatorLable.text = ""
        currentFormula.removeAll()
    }
    
    @IBAction private func CEButtonTapped(_ sender: UIButton) {
        if let lastIndex = currentFormula.last, Double(String(lastIndex)) != nil {
            numberLable.text = String((numberLable.text ?? "0").dropLast())
        } else {
            operatorLable.text = ""
        }
        
        if numberLable.text == "" {
            numberLable.text = "0"
        }
        
        currentFormula = String(currentFormula.dropLast())
    }
    
    @IBAction private func changeSignButtonTapped(_ sender: UIButton) {
        let numberText = numberLable.text ?? "0"
        let pureNumber = numberText.filter { $0 != "," }
        
        guard numberText != "0" else {
            return
        }
      
        if numberText.contains("-") {
            let plusNumber = numberText.dropFirst()
            let purePlusNumber = plusNumber.filter { $0 != "," }
            numberLable.text = String(plusNumber)
            currentFormula = String(currentFormula.dropLast(pureNumber.count)) + purePlusNumber
        } else {
            let minusNumber = "-" + numberText
            let pureMinusNumber = minusNumber.filter { $0 != "," }
            numberLable.text = minusNumber
            currentFormula = String(currentFormula.dropLast(pureNumber.count)) + pureMinusNumber
        }
    }
    
    @IBAction func decimalPointButtonTapped(_ sender: UIButton) {
        let numberText = numberLable.text ?? "0"
        
        if !numberText.contains(".") {
            numberLable.text = numberText + "."
            currentFormula += "."
        }
    }
}

