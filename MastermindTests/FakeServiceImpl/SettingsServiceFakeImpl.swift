//
//  SettingsServiceFakeImpl.swift
//  MastermindTests
//
//  Created by Tatiana Ampilogova on 12/28/22.
//

import Foundation
@testable import Mastermind

class SettingsServiceFake: SettingsService {
    var currentComplexityLevel = ComplexityLevel.easy
}
