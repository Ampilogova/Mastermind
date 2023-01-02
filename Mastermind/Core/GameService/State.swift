//
//  State.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/26/22.
//

import UIKit

enum State: String, CaseIterable {
    case win
    case lose
    case inProggress
    
    var title: String {
        switch self {
        case .win:
            return "You win!"
        case .lose:
            return "You lose"
        case .inProggress:
            return ""
        }
    }
}
