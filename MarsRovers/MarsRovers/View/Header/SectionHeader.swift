//
//  SectionHeader.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let titleHeader = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleHeader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleHeader)
        
        // устанавливаем констрейнты для заголовка
        NSLayoutConstraint.activate([
            titleHeader.topAnchor.constraint(equalTo: self.topAnchor),
            titleHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(text: String, font: UIFont?) {
        titleHeader.text = text
        titleHeader.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
