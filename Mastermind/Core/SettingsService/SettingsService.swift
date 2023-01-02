//
//  SettingsService.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/22/22.
//

import Foundation

public protocol SettingsService {
    var currentComplexityLevel: ComplexityLevel { get set }
}

class SettingsServiceImpl: SettingsService {
    
    private let userDefaults = UserDefaults.standard
    
    var currentComplexityLevel: ComplexityLevel {
        get {
            guard let value = userDefaults.string(forKey: #function),
                  let level = ComplexityLevel(rawValue: value) else {
                return .easy
            }
            return level
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: #function)
        }
    }
}
