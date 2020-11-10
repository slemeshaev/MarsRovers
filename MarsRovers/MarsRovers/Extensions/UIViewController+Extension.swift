//
//  UIViewController+Extension.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 10.11.2020.
//

import UIKit

extension UIViewController {
    // метод конфигурации ячейки
    func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Невозможно исключить из очереди \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
}
