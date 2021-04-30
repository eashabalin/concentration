//
//  ViewController.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return buttonCollection.count / 2
    }
    
    private(set) var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
//    private var emojiCollection = ["🦊", "🐰", "🐸", "🐶", "🐭", "🐻", "🐷", "🐮", "🦁", "🐯", "🐨", "🐻‍❄️", "🐼"]
    private var emojiCollection = "🦊🐰🐸🐶🐭🐻🐷🐮🦁🐯🐨🐻‍❄️🐼"
    
    private var emojiDictionary = [Card: String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card] == nil {
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .white : #colorLiteral(red: 0.360244453, green: 0.3216490746, blue: 0.8701937795, alpha: 1)
            }
        }
    }
    
    @IBOutlet private weak var touchLabel: UILabel!
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBAction private func buttonTouched(_ sender: UIButton) {
        guard !game.checkForFinish() else { return }
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
        if game.checkForFinish() {
            touchLabel.text = "Won in \(touches) steps!"
        }
    }
    @IBAction private func restartTouched(_ sender: UIButton) {
        touches = 0
        game = ConcentrationGame(numberOfPairsOfCards: buttonCollection.count / 2)
        emojiCollection = "🦊🐰🐸🐶🐭🐻🐷🐮🦁🐯🐨🐻‍❄️🐼"
        updateViewFromModel()
    }
}

extension Int {
    var arc4randomExtension: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
