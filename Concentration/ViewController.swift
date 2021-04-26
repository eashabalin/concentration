//
//  ViewController.swift
//  Concentration
//
//  Created by Егор Шабалин on 26.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    func flipButton(emoji: String, button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.5791060328, blue: 0.5821195841, alpha: 1)
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
    
    
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var touchLabel: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        flipButton(emoji: "🦊", button: sender)
    }
}

