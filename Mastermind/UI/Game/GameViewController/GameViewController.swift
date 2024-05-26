//
//  ViewController.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

class GameViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, OptionsViewControllerDelegate, AnswerViewControllerDelegate {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private let loaderView = UIView()
    private var activityView = UIActivityIndicatorView(style: .large)
    private let answerViewController = AnswerViewController()
    private let optionsViewController = OptionsViewController()
    private var gameService: GameService
    private var game = Game(answer: [], length: 0, size: 0)
    
    init(gameService: GameService) {
        self.gameService = gameService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
        setUpUI()
    }

    private func setUpGame() {
        self.answerViewController.updateAnswer(game.answer)
        self.optionsViewController.updateOptions(game.options)
        self.collectionView.reloadData()
    }
    
    private func startGame() {
        self.loaderView.isHidden = false
        activityView.startAnimating()
        gameService.createGame { [weak self] result in
            switch result {
            case .success(let game):
                self?.game = game
                DispatchQueue.main.async {
                    self?.setUpGame()
                    self?.loaderView.isHidden = true
                    self?.activityView.stopAnimating()
                    self?.scrollToBottom()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showErrorAlert(title: "Something went wrong", message: error.localizedDescription, handler: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
    }

    private func setUpAnswerView() {
        answerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        answerViewController.delegate = self
        addChild(answerViewController)
        self.view.addSubview(answerViewController.view)
        answerViewController.didMove(toParent: self)
        NSLayoutConstraint.activate([
            answerViewController.view.heightAnchor.constraint(equalToConstant: 80),
            answerViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            answerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setUpOptionsView() {
        optionsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(optionsViewController)
        self.view.addSubview(optionsViewController.view)
        optionsViewController.didMove(toParent: self)
        optionsViewController.delegate = self
        NSLayoutConstraint.activate([
            optionsViewController.view.heightAnchor.constraint(equalToConstant: 60),
            optionsViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            optionsViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            optionsViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.register(FieldItemCell.self, forCellWithReuseIdentifier: FieldItemCell.className)
        collectionView.register(HintCell.self, forCellWithReuseIdentifier: HintCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: answerViewController.view.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: optionsViewController.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
    }
    
    private func setUpLoaderView() {
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        loaderView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            loaderView.topAnchor.constraint(equalTo: view.topAnchor),
            loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
    private func setUpUI() {
        view.backgroundColor = .systemBackground
        setUpAnswerView()
        setUpOptionsView()
        setUpCollectionView()
        setUpLoaderView()
    }
    
    //MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return game.field.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Additional item for hint cell.
        let count = game.field[0].count + 1
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == game.field[0].count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HintCell.className, for: indexPath) as! HintCell
            let hints = game.hints[indexPath.section]
            cell.configure(hints)
            if game.currentPosition.column < game.size {
                cell.checkAnswerImageView.isHidden = true
            } else if indexPath.section == game.currentPosition.row {
                cell.checkAnswerImageView.isHidden = false
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FieldItemCell.className, for: indexPath) as! FieldItemCell
            let item = game.field[indexPath.section][indexPath.row]
            cell.makeCircleLabel()
            cell.configure(item)
            cell.label.accessibilityHint = "Double tap to discard"
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == game.currentPosition.row && indexPath.row == game.size && game.currentPosition.column == game.size {
            let state = game.verifyCandidate()
            if state == .win || state == .lose {
                answerViewController.showAnswer()
                self.showRestartAlert(title: state.title, message: "Try again", handler: {
                    self.startGame()
                })
            }
        } else if indexPath.section == game.currentPosition.row {
            game.discard(at: indexPath.row)
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width / CGFloat(game.size + 1)).rounded(.down)
        return CGSize(width: size, height: size)
    }
    
    func scrollToBottom() {
        let section = collectionView.numberOfSections - 1
        let indexPath = IndexPath(item: 0, section: section)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    //MARK: - OptionsViewControllerDelegate
    
    func didSelectOption(option: FieldItem) {
        game.makeTurn(option)
        collectionView.reloadData()
    }
    
    //MARK: - AnswerViewControllerDelegate
    
    func didRestartViewTapped() {
        startGame()
    }
    
    //MARK: - Alert
    private func showRestartAlert(title: String, message: String, handler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Restart", style: .default, handler: { (action) in
            handler?()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showErrorAlert(title: String, message: String, handler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            handler?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}

