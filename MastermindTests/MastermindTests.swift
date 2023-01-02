//
//  MastermindTests.swift
//  MastermindTests
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import XCTest
@testable import Mastermind

private class MastermindTests: XCTestCase {
    
    let fakeNetworkService = NetworkServiceFakeImpl()

    func testNumberGeneratorService() {
        let data = Data("""
        2
        7
        6
        5
        """.utf8)
        fakeNetworkService.data = data
        
        let numberGeneratorService = NumberGeneratorServiceImpl(networkService: fakeNetworkService)
        var randomNumbers = [String]()
        numberGeneratorService.generateNumbers(count: "4") { result in
            switch result {
            case .success(let numbers):
                randomNumbers = numbers
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(randomNumbers.count, 4)
        XCTAssertEqual(randomNumbers, ["2","7","6","5"])
    }
    
    func testNumberGeneratorService_networkError() {
        fakeNetworkService.error = NSError("Connection error")
        
        let numberGeneratorService = NumberGeneratorServiceImpl(networkService: fakeNetworkService)
        var error: Error? = nil
        numberGeneratorService.generateNumbers(count: "4") { result in
            switch result {
            case .failure(let  resultError):
                error = resultError
            default: break
            }
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, "Connection error")
    }
    
    func testGameService() {
        verifyGameService(complexityLevel: .easy)
        verifyGameService(complexityLevel: .medium)
        verifyGameService(complexityLevel: .hard)
    }
    
    func verifyGameService(complexityLevel: ComplexityLevel) {
        let settingsService = SettingsServiceFake()
        settingsService.currentComplexityLevel = complexityLevel
        let numberGeneratorService = NumberGeneratorServiceFake()
        numberGeneratorService.numbers = ["1", "2", "3", "4"]
        let gameService = GameServiceImpl(numberGeneratorService: numberGeneratorService, settingsService: settingsService)
        var game = Game(answer: [], length: 0, size: 0)
        gameService.createGame { result in
            switch result {
            case .success(let resultGame):
                game = resultGame
            case .failure(_):
                break
            }
        }

        XCTAssertEqual(game.field.count, complexityLevel.numberOfAttemps)
        XCTAssertEqual(game.field[0].count, complexityLevel.size)
        XCTAssertEqual(game.answer.count, 4)
    }

    func testGame_win() {
        var game = Game(answer: ["1", "2", "3", "4"], length: 8, size: 4)
        game.makeTurn(game.options[1])
        game.makeTurn(game.options[2])
        game.makeTurn(game.options[3])
        game.makeTurn(game.options[4])
        
        let state = game.verifyCandidate()
        XCTAssertEqual(state, .win)
        
    }
    
    func testGame_lose() {
        var game = Game(answer: ["1", "2", "3", "4"], length: 8, size: 4)
        var state = State.inProggress
        for _ in 0..<game.numberOfAttempts {
            game.makeTurn(game.options[1])
            game.makeTurn(game.options[1])
            game.makeTurn(game.options[1])
            game.makeTurn(game.options[1])
            state = game.verifyCandidate()
        }
        
        XCTAssertEqual(state, .lose)
    }
}
