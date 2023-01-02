//
//  NumberGeneratorServiceFakeImpl.swift
//  MastermindTests
//
//  Created by Tatiana Ampilogova on 12/28/22.
//

import Foundation
@testable import Mastermind

class NumberGeneratorServiceFake: NumberGeneratorService {
    var numbers = [String]()
    
    func generateNumbers(count: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        completion(.success(numbers))
    }
}
