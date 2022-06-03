import UIKit

extension String {
    func split(with target: Character) -> [String] {
        guard !self.isEmpty else { return [""] }
        
        var element = ""
        var result: [String] = []
        
        self.forEach {
            if $0 != target {
                element += String($0)
            } else {
                result.append(element)
                result.append(String($0))
                element.removeAll()
            }
        }

        if !element.isEmpty {
            result.append(element)
        }
        
        return result
    }
}

extension Double: CalculateItem {
    
}

extension UIStackView {
    func removeAllArrangedSubview() {
        self.arrangedSubviews.forEach({ child in
            self.removeArrangedSubview(child)
            child.removeFromSuperview()
        })
    }
    
    func addLabel(arithmetic: String) {
        var arithmeticText = arithmetic
    
        if arithmetic.last == "." {
            arithmeticText.removeLast()
        }
        
        let label = UILabel()
        label.text = arithmeticText
        label.textColor = .white
        self.addArrangedSubview(label)
    }
}