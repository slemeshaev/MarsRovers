//
//  String+Extension.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 14.11.2020.
//

import Foundation

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
