//
//  NetworkRequest.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import Foundation

public struct NetworkRequest {
    var url: String
    var parameters = [String: String]()
    
    func buildURLRequest() -> URLRequest? {
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = parameters.map({ URLQueryItem(name: $0, value: $1) })
        guard let url = urlComponents?.url else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
