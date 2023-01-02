//
//  NetworkService.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import Foundation

public protocol NetworkService {
    //Send request
    func send(request: NetworkRequest, completion: @escaping (Result<Data,Error>) -> Void)
}

class NetworkServiceImpl: NetworkService {
    
    private let urlSession = URLSession.shared
    
    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = request.buildURLRequest() else {
            completion(.failure(NSError("Wrong URL")))
            return
        }
        let dataTask = urlSession.dataTask(with: url) { data, responce, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError("Network error")))
            }
        }
        dataTask.resume()
    }
}
