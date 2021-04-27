//
//  ViewController.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: buttonCollection.count / 2)
    
    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    var emojiCollection = ["🦊", "🐰", "🐸", "🐶", "🐭", "🐻", "🐷", "🐮", "🦁", "🐯", "🐨", "🐻‍❄️", "🐼"]
    
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func updateViewFromModel() {
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
    
    @IBOutlet weak var touchLabel: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBAction func buttonTouched(_ sender: UIButton) {
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
    @IBAction func restartTouched(_ sender: UIButton) {
        touches = 0
        game = ConcentrationGame(numberOfPairsOfCards: buttonCollection.count / 2)
        emojiCollection = ["🦊", "🐰", "🐸", "🐶", "🐭", "🐻", "🐷", "🐮", "🦁", "🐯", "🐨", "🐻‍❄️", "🐼"]
        updateViewFromModel()
    }
}
