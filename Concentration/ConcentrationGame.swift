//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import Foundation

class ConcentrationGame {
    
    private(set) var cards = [Card]()
    
    private var oneAndOnlyFaseUpCardIndex: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchingCardIndex = oneAndOnlyFaseUpCardIndex {
                if cards[index] == cards[matchingCardIndex], index != matchingCardIndex {
                    cards[index].isMatched = true
                    cards[matchingCardIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
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
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init(\(numberOfPairsOfCards): must have at least one pair of cards")
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
