//
//  MenuViewController.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/22/22.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let startButton = UIButton()
    private let settingsButton = UIButton()
    private let gameService: GameService
    private let settingsService: SettingsService
    
    init(gameService: GameService, settingsService: SettingsService) {
        self.gameService = gameService
        self.settingsService = settingsService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        startButton.backgroundColor = .systemOrange
        startButton.makeRoundedButton()
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        settingsButton.backgroundColor = .systemGreen
        settingsButton.makeRoundedButton()
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 200),
            settingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func startTapped() {
        let vc = GameViewController(gameService: gameService)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func settingsTapped() {
        let vc = SettingsViewController(settingsService: settingsService)
        navigationController?.pushViewController(vc, animated: true)
    }
}
