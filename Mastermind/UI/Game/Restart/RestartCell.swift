//
//  RestartCell.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/26/22.
//

import UIKit

class RestartCell: UICollectionViewCell {
    
    private let restartGameImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        restartGameImageView.translatesAutoresizingMaskIntoConstraints = false
        restartGameImageView.isAccessibilityElement = true
        restartGameImageView.accessibilityTraits = .button
        restartGameImageView.accessibilityHint = "Double tap to restart"
        restartGameImageView.image = UIImage(systemName: "arrow.clockwise")
        restartGameImageView.tintColor = .systemOrange
        contentView.addSubview(restartGameImageView)
        NSLayoutConstraint.activate([
            restartGameImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            restartGameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            restartGameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            restartGameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
