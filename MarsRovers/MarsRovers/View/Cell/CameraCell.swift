//
//  CameraCell.swift
//  MarsRovers
//
//  Created by Станислав Лемешаев on 09.11.2020.
//

import UIKit

class CameraCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "CameraCellId"
    
    let snapshotImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        setupConstraints()
    }
    
    func configure<U>(with value: U) where U : Hashable {
//        guard let chat: MChat = value as? MChat else { return }
//        friendImageView.sd_setImage(with: URL(string: chat.friendUserImageString), completed: nil)
//        friendName.text = chat.friendUsername
//        lastMessage.text = chat.lastMessageContent
    }
    
    // установка констрейнтов для friendImageView
    private func setupConstraints() {
        snapshotImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(snapshotImageView)
        
        NSLayoutConstraint.activate([
            // растягиваем изображение по всему imageView
            snapshotImageView.topAnchor.constraint(equalTo: self.topAnchor),
            snapshotImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            snapshotImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            snapshotImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

