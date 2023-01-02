//
//  Hint.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

enum Hint {
    case wrongPlace
    case correct
    case empty
    
    var color: UIColor {
        switch self {
        case .wrongPlace:
            return .white
        case .correct:
            return .systemGray
        case .empty:
            return .systemGray5
        }
    }
    
    var title: String {
        switch self {
        case .wrongPlace:
            return "Wrong place"
        case .correct:
            return "Correct"
        case .empty:
            return "Empty"
        }
    }
}
