//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import Foundation

class ConcentrationGame {
    
    var cards = [Card]()
    var cardsUnshuffled = [Card]()
    var randomIndicies = [Int]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index {
                if cards[matchingIndex].identifier == cards[index].identifier {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDown in cards.indices {
                    cards[flipDown].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cardsUnshuffled += [card, card]
        }
        randomIndicies = Array(Set(0...(numberOfPairsOfCards * 2 - 1)))
        for index in randomIndicies {
            cards.append(cardsUnshuffled[index])
        }
    }
}
