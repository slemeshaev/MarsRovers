//
//  SelfConfiguringCell.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

// протокол для конфигурации ячеек
protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with value: MImage)
}
