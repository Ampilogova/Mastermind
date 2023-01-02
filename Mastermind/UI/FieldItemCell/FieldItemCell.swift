//
//  FieldItemCell.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

class FieldItemCell: UICollectionViewCell {
    
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.textAlignment = .center
        label.isAccessibilityElement = true
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
        ])
    }
    
    func configure(_ item: FieldItem) {
        label.text = item.emoji
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    func makeCircleLabel() {
        label.backgroundColor = .systemGray5
        label.layer.cornerRadius = bounds.height / 2
        label.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
