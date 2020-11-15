//
//  SectionHeader.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseId = "SectionHeader"
    
    let containerView = UIView()
    let titleHeader = UILabel()
    let buttonArrow = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleHeader.translatesAutoresizingMaskIntoConstraints = false
        buttonArrow.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(titleHeader)
        containerView.addSubview(buttonArrow)
        
        buttonArrow.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        buttonArrow.addTarget(self, action: #selector(showAllPhotos), for: .touchUpInside)
        
        // констрейнты для контейнера
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // устанавливаем констрейнты для заголовка
        NSLayoutConstraint.activate([
            titleHeader.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleHeader.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleHeader.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleHeader.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // устанавливаем констрейнты для кнопки
        NSLayoutConstraint.activate([
            buttonArrow.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonArrow.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 100),
            buttonArrow.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            buttonArrow.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // функция показать фотографии
    @objc func showAllPhotos() {
        print("Сделать переход на PhotoViewController")
//        let camerasVC = CamerasViewController()
//        let photoVC = PhotoViewController()
//        camerasVC.navigationController?.pushViewController(photoVC, animated: true)
    }
    
    // метод конфигурации ячейки
    func configure(text: String, font: UIFont?) {
        titleHeader.text = text
        titleHeader.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
