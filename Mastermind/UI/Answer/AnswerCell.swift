//
//  AnswerCell.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/26/22.
//

import Foundation

import UIKit

class AnswerCell: UICollectionViewCell {
    
    private let emojiLabel = UILabel()
    private let answerView = UIView()
    private let questionMark = "?"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        answerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerView)
        NSLayoutConstraint.activate([
            answerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            answerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            answerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            answerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
        
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emojiLabel)
        emojiLabel.textAlignment = .center
        emojiLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        NSLayoutConstraint.activate([
            emojiLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            emojiLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            emojiLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            emojiLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ item: FieldItem, isGameFinished: Bool) {
        if isGameFinished {
            self.answerView.isHidden = true
            self.emojiLabel.text = item.emoji
        } else {
            self.answerView.isHidden = false
            self.emojiLabel.text = questionMark
            self.emojiLabel.textColor = .white
            answerView.backgroundColor = .systemOrange
            answerView.layer.cornerRadius = (bounds.height - 2) / 2
            answerView.layer.masksToBounds = true
        }
    }
}
