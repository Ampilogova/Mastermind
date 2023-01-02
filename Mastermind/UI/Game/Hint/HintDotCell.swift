//
//  HintDotCell.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/21/22.
//

import UIKit

class HintDotCell: UICollectionViewCell {
    
    private let hintView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hintView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hintView)
        hintView.layer.cornerRadius = 8
        hintView.layer.masksToBounds = true
        hintView.backgroundColor = .systemGray5
        NSLayoutConstraint.activate([
            hintView.heightAnchor.constraint(equalToConstant: 16),
            hintView.widthAnchor.constraint(equalToConstant: 16),
            hintView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hintView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(_ hint: Hint) {
        switch hint {
        case .wrongPlace:
            self.hintView.backgroundColor = hint.color
            self.hintView.layer.borderColor = UIColor.systemGray.cgColor
            self.hintView.layer.borderWidth = 1
        case .correct, .empty:
            self.hintView.backgroundColor = hint.color
        }
        self.hintView.isAccessibilityElement = true
        self.hintView.accessibilityLabel = hint.title
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        hintView.backgroundColor = .systemGray5
        hintView.layer.borderColor = nil
        hintView.layer.borderWidth = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
