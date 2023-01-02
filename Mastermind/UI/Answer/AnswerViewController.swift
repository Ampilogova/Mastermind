//
//  AnswerViewController.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

protocol AnswerViewControllerDelegate: AnyObject {
    func didRestartViewTapped()
}

class AnswerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private var answer = [FieldItem]()
    private var isGameFinished = false
    weak var delegate: AnswerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    func updateAnswer(_ answer: [FieldItem]) {
        self.answer = answer
        self.isGameFinished = false
        collectionView.reloadData()
    }
    
    func showAnswer() {
        self.isGameFinished = true
        collectionView.reloadData()
    }
    
    private func setUpCollectionView() {
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: AnswerCell.className)
        collectionView.register(RestartCell.self, forCellWithReuseIdentifier: RestartCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
    
    //MARK: - AnswerViewControllerDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Additional item for restart button.
        return answer.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == answer.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestartCell.className, for: indexPath) as! RestartCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnswerCell.className, for: indexPath) as! AnswerCell
            let item = answer[indexPath.row]
            cell.configure(item, isGameFinished: isGameFinished)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == answer.count {
            delegate?.didRestartViewTapped()
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / CGFloat(answer.count + 1).rounded(.down)
        return CGSize(width: size, height: size)
    }
}
