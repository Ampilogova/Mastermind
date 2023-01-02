//
//  Game.swift
//  Mastermind
//
//  Created by Tatiana Ampilogova on 12/20/22.
//

import UIKit

struct Game {
    
    private(set) var field: [[FieldItem]]
    private(set) var answer: [FieldItem]
    private(set) var hints: [[Hint]]
    private(set) var currentPosition: Point
    let options: [FieldItem]
    let size: Int
    let numberOfAttempts: Int
    
    init(answer: [String], length: Int, size: Int) {
        self.numberOfAttempts = length
        self.size = size
        self.options = Emojis.dict.map({ FieldItem(id: $0.key, emoji: $0.value )}).sorted(by: ({ $0.id < $1.id }))
        self.currentPosition = Point(row: length - 1, column: 0)
        let row = Array(repeating: FieldItem(id: "", emoji: ""), count: size)
        self.field = Array(repeating: row, count: length)
        
        let rowHints = Array(repeating: Hint.empty, count: size)
        self.hints = Array(repeating: rowHints, count: length)
        
        self.answer = answer.map({
            if let emoji = Emojis.dict[$0] {
                return FieldItem(id: $0, emoji: emoji)
            } else {
                assertionFailure("No emoji found for value: \($0)")
                return FieldItem(id: $0, emoji: "")
            }
        })
    }
    
    mutating func makeTurn(_ item: FieldItem) {
        // Do not allow the user to select another option because the line is full.
        if currentPosition.column >= size {
            return
        }
        //Assign item to the field and move the point.
        field[currentPosition.row][currentPosition.column] = item
        if currentPosition.column == size - 1 {
            currentPosition.column += 1
        } else {
            updateCurrentPosition()
        }
    }
    
    mutating func verifyCandidate() -> State {
        let candidate = field[currentPosition.row]
        if answer == candidate {
            return .win
        }

        if answer != candidate && currentPosition.row == 0 {
            return .lose
        }
        
        var candidateDict = [String: Int]()
        var answerDict = [String: Int]()
        var currentHints = [Hint]()
        
        for (element1, element2) in zip(candidate, answer) {
            //Collecting the correct answers in an array.
            if element1.id == element2.id {
                currentHints.append(.correct)
            } else {
                //Store the rest in 2 dictionaries to calculate wrong place items.
                candidateDict[element1.id, default: 0] += 1
                answerDict[element2.id, default: 0] += 1
            }
        }
        // Compare if candidateDict and answerDict have common values. If there is add to array as .wrongPlace.
        for (key, answerCount) in answerDict {
            if let candidateCount = candidateDict[key] {
                let count = min(answerCount, candidateCount)
                currentHints += Array(repeating: .wrongPlace, count: count)
            }
        }
        //Add .empty values to make HintsCell display placeholders.
        currentHints += Array(repeating: .empty, count: size - currentHints.count)
        hints[currentPosition.row] = currentHints
        
        // Move point to the next row
        currentPosition.column = 0
        currentPosition.row -= 1
        return .inProggress
    }
    
    mutating func discard(at index: Int) {
        field[currentPosition.row][index] = FieldItem(id: "", emoji: "")
        updateCurrentPosition()
    }
    
    private mutating func updateCurrentPosition() {
        for i in 0..<field[currentPosition.row].count {
            let item = field[currentPosition.row][i]
            if item.id == "" {
                currentPosition.column = i
                break
            } else {
                currentPosition.column = size
            }
        }
    }
}
