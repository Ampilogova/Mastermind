//
//  HintCell.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

class HintCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let checkAnswerImageView = UIImageView()
    private lazy var collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout())
    private var hints = [Hint]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        
        checkAnswerImageView.isUserInteractionEnabled = true
        checkAnswerImageView.translatesAutoresizingMaskIntoConstraints = false
        checkAnswerImageView.backgroundColor = .systemGreen
        checkAnswerImageView.isAccessibilityElement = true
        checkAnswerImageView.accessibilityLabel = "Row compleated, double tap to show hints"
        checkAnswerImageView.image = UIImage(systemName: "arrow.left.circle")
        checkAnswerImageView.tintColor = .white
        contentView.addSubview(checkAnswerImageView)
        NSLayoutConstraint.activate([
            checkAnswerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            checkAnswerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            checkAnswerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            checkAnswerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(HintDotCell.self, forCellWithReuseIdentifier: HintDotCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - HintsCellDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hints.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintDotCell.className, for: indexPath) as! HintDotCell
        let item = hints[indexPath.row]
        cell.configure(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width / sqrt(CGFloat(hints.count)).rounded(.up)
        return CGSize(width: size.rounded(.down), height: size.rounded(.down))
    }
    
    func configure(_ hints: [Hint]) {
        self.hints = hints
        checkAnswerImageView.makeRoundedButton()
        self.checkAnswerImageView.isHidden = true
        self.collectionView.reloadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.hints = []
        self.checkAnswerImageView.isHidden = true
    }
}



