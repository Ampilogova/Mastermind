//
//  GameService.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import Foundation

protocol GameService {
    // Create new game
    func createGame(comletion: @escaping (Result<Game, Error>) -> Void)
}

class GameServiceImpl: GameService {
    private let numberGeneratorService: NumberGeneratorService
    private let settingsService: SettingsService
    
    init(numberGeneratorService: NumberGeneratorService, settingsService: SettingsService) {
        self.numberGeneratorService = numberGeneratorService
        self.settingsService = settingsService
    }
    
    func createGame(comletion: @escaping (Result<Game, Error>) -> Void) {
        let num = self.settingsService.currentComplexityLevel.size
        numberGeneratorService.generateNumbers(count: num) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                let size = self.settingsService.currentComplexityLevel.size
                let length = self.settingsService.currentComplexityLevel.numberOfAttemps
                let game = Game(answer: result, length: length, size: size)
                comletion(.success(game))
            case .failure(let error):
                comletion(.failure(error))
            }
        }
    }
}
