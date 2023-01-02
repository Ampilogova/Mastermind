//
//  NetworkServiceFakeImpl.swift
//  MastermindTests
//
//  Created by Tatiana Ampilogova on 12/27/22.
//

import Foundation
@testable import Mastermind

class NetworkServiceFakeImpl: NetworkService {
    
    var data = Data()
    var error: Error?
    
    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(data))
        }
    }
}
