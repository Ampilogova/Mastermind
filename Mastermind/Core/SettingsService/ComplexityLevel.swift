//
//  ComplexityLevel.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/23/22.
//

import Foundation

public enum ComplexityLevel: String, CaseIterable {
    case easy
    case medium
    case hard
    
    var title: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
    
    var description: String {
        return "Field size \(size)\nNumber of attempts \(numberOfAttemps)"
    }
    
    var size: Int {
        switch self {
        case .easy:
            return 4
        case .medium:
            return 5
        case .hard:
            return 5
        }
    }
    
    var numberOfAttemps: Int {
        switch self {
        case .easy:
            return 10
        case .medium:
            return 10
        case .hard:
            return 8
        }
    }
}
