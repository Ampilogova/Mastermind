//
//  NSError.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/27/22.
//

import Foundation

extension NSError {
    
    convenience init(_ description: String) {
        self.init(domain: "Local domain", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
