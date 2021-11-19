//
//  CalculatorVC+Extension.swift
//  Calculator
//
//  Created by Seul Mac on 2021/11/19.
//

import UIKit

extension CalculatorViewController {
    
    var operatorLabel: UILabel {
        let operatorLabel = UILabel()
        operatorLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        operatorLabel.textColor = .white
        operatorLabel.text = inputOperatorLabel.text
        
        return operatorLabel
    }
    
    var operandsLabel: UILabel {
        let operandsLabel = UILabel()
        operandsLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        operandsLabel.textColor = .white
        operandsLabel.text = inputNumLabel.text
        
        return operandsLabel
    }
    
}
