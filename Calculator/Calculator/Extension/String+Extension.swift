//
//  String+Extension.swift
//  Calculator
//
//  Created by hoon, hemg on 2023/06/06.
//

extension String {
    func split(with target: Character) -> [String] {
        return split(separator: target, omittingEmptySubsequences: false).map { String($0) }
    }
}