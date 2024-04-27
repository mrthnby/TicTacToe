//
//  ViewController.swift
//  TicTacToe
//
//  Created by Mert Ali Hanbay on 27.04.2024.
//

import UIKit

class ViewController: UIViewController {

    enum Turn: String {
        case X = "X"
        case O = "O"
    }

    var firstTurn = Turn.X
    var currentTurn = Turn.X

    // Crosses score, Noughts score
    var scores: (Int, Int) = (0, 0)

    @IBOutlet var turnLabel: UILabel!
    @IBOutlet var a1: UIButton!
    @IBOutlet var a2: UIButton!
    @IBOutlet var a3: UIButton!
    @IBOutlet var b1: UIButton!
    @IBOutlet var b2: UIButton!
    @IBOutlet var b3: UIButton!
    @IBOutlet var c1: UIButton!
    @IBOutlet var c2: UIButton!
    @IBOutlet var c3: UIButton!

    var board = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }

    func initBoard() {
        board.append(contentsOf: [a1, a2, a3, b1, b2, b3, c1, c2, c3])
    }

    @IBAction func boardTapAction(_ sender: UIButton) {
        drawOnBoard(sender)

        let result = checkResult()
        if result.0 {
            if(result.1 == Turn.X) {
                scores.0 += 1
                showResult("Crosses Win!")
            } else {
                scores.1 += 1
                showResult("Noughts Win")
            }
        }

        if isGameOver() {
            showResult("Draw!")
        }
    }

    func checkResult() -> (Bool, Turn?) {
        if areButtonsSame([a1, b1, c1]) || areButtonsSame([a1, a2, a3]) || areButtonsSame([a1, b2, c3]) {
            return (true, a1.titleLabel?.text == Turn.X.rawValue ? Turn.X : Turn.O)
        }
        if areButtonsSame([a2, b2, c2]) || areButtonsSame([b1, b2, b3]) || areButtonsSame([a3, b2, c1]) {
            return (true, b2.titleLabel?.text == Turn.X.rawValue ? Turn.X : Turn.O)
        }
        if areButtonsSame([a3, b3, c3]) || areButtonsSame([c1, c2, c3]) {
            return (true, c3.titleLabel?.text == Turn.X.rawValue ? Turn.X : Turn.O)
        }
        return (false, nil)
    }

    func areButtonsSame(_ buttons: [UIButton]) -> Bool {
        let first = buttons.first?.titleLabel?.text
        if(first == nil) {return false}
        for button in buttons {
            if(button.titleLabel?.text != first || button.titleLabel?.text == nil) { return false }
        }
        return true
    }

    func showResult(_ title: String) {
        let message = "\nCrosses: " + String(scores.0) + "\nNouhts: " + String(scores.1)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { _ in
            self.resetGame()
        }))
        self.present(ac, animated: true)
    }

    func resetGame() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.titleLabel?.text = nil
            button.isEnabled = true
        }
        if firstTurn == Turn.X {
            firstTurn = Turn.O
        } else {
            firstTurn = Turn.X
        }
        currentTurn = firstTurn
        turnLabel.text = firstTurn.rawValue
    }

    func drawOnBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            if(currentTurn == Turn.X) {
                sender.setTitle(Turn.X.rawValue, for: .normal)
                currentTurn = Turn.O
                turnLabel.text = Turn.O.rawValue
            } else if(currentTurn == Turn.O) {
                sender.setTitle(Turn.O.rawValue, for: .normal)
                currentTurn = Turn.X
                turnLabel.text = Turn.X.rawValue
            }
            sender.isEnabled = false
        }
    }

    func isGameOver() -> Bool {
        for button in board {
            if(button.title(for: .normal) == nil) {
                return false
            }
        }
        return true
    }
}

