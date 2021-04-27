//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import Foundation

class ConcentrationGame {
    
    var cards = [Card]()
    
    var oneAndOnlyFaseUpCardIndex: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingCardIndex = oneAndOnlyFaseUpCardIndex {
                if cards[index].identifier == cards[matchingCardIndex].identifier, index != matchingCardIndex {
                    cards[index].isFaceUp = true
                    cards[index].isMatched = true
                    cards[matchingCardIndex].isMatched = true
                } else {
                    cards[index].isFaceUp = true
                }
                oneAndOnlyFaseUpCardIndex = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                cards[index].isFaceUp = true
                oneAndOnlyFaseUpCardIndex = index
            }
        }
    }
    
    func checkForFinish() -> Bool {
        for card in cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    
    init(numberOfPairsOfCards: Int) {
        var unshuffledCards = [Card]()
        let shuffledIndices = Array(Set(0...numberOfPairsOfCards * 2 - 1))
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffledCards += [card, card]
        }
        for index in shuffledIndices {
            cards.append(unshuffledCards[index])
        }
    }
}
