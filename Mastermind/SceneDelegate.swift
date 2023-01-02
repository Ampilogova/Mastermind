//
//  SceneDelegate.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: sceneWindow)
        let networkService = NetworkServiceImpl()
        let numberGenerationService = NumberGeneratorServiceImpl(networkService: networkService)
        let settingsService = SettingsServiceImpl()
        let gameService = GameServiceImpl(numberGeneratorService: numberGenerationService, settingsService: settingsService)
        let menuViewController = MenuViewController(gameService: gameService, settingsService: settingsService)
        let navigationViewController = UINavigationController(rootViewController: menuViewController)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        window.backgroundColor = .systemBackground
        self.window = window
    }
}

