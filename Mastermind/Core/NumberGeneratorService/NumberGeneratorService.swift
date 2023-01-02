//
//  NumberGeneratorService.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import Foundation

public protocol NumberGeneratorService {
    // Load random numbers
    func generateNumbers(count: Int, completion: @escaping (Result<[String], Error>) -> Void)
}

class NumberGeneratorServiceImpl: NumberGeneratorService {
    private let stringUrl = "https://www.random.org/integers/"
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func generateNumbers(count: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        var networkRequest = NetworkRequest(url: stringUrl)
        networkRequest.parameters = ["num": String(count),
                                     "min": "0",
                                     "max": "7",
                                     "col": "1",
                                     "base": "10",
                                     "format": "plain"]
        networkService.send(request: networkRequest) { result in
            switch result {
            case .success(let data):
                let numbers = String(data: data, encoding: .utf8)
                let array = numbers?.components(separatedBy: .newlines).filter({ !$0.isEmpty })
                completion(.success(array ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
