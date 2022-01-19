//
//  ViewController.swift
//  laa_MohitKumar_c0817241
//
//  Created by Mohit Kumar on 18/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum squidGame {
        case OZero
        case XCross
    }
    
    
    @IBOutlet weak var crossXScore: UILabel!
    @IBOutlet weak var oZeroScore: UILabel!
    
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var a: UIButton!
    @IBOutlet weak var b: UIButton!
    @IBOutlet weak var c: UIButton!
    @IBOutlet weak var alpha: UIButton!
    @IBOutlet weak var beta: UIButton!
    @IBOutlet weak var sigma: UIButton!
    
    var firstsquidGame = squidGame.XCross
    var currentsquidGame = squidGame.XCross
    
    var CROSSX = "X"
    var ZEROO = "O"
    
    var board = [UIButton]()
    
    var zeroOScore = 0
    var crossesScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard()
    {
        board.append(one)
        board.append(two)
        board.append(three)
        board.append(a)
        board.append(b)
        board.append(c)
        board.append(alpha)
        board.append(beta)
        board.append(sigma)
    }
    
    @IBAction func boardTap(_ sender: Any) {
        addToBoard(sender as! UIButton)
        
        if checkForVictory(CROSSX)
        {
            crossesScore += 1
            crossXScore.text = String(crossesScore)
            resultAlert(title: "Crosses Win!")
        }
        
        if checkForVictory(ZEROO)
        {
            zeroOScore += 1
            oZeroScore.text = String(zeroOScore)
            resultAlert(title: "Zeros Win!")
        }
        
        if(fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func resetBoard()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstsquidGame == squidGame.OZero
        {
            firstsquidGame = squidGame.XCross
        }
        else if firstsquidGame == squidGame.XCross
        {
            firstsquidGame = squidGame.OZero
        }
        currentsquidGame = firstsquidGame
    }
    
    func fullBoard() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentsquidGame == squidGame.OZero)
            {
                sender.setTitle(ZEROO, for: .normal)
                currentsquidGame = squidGame.XCross
            }
            else if(currentsquidGame == squidGame.XCross)
            {
                sender.setTitle(CROSSX, for: .normal)
                currentsquidGame = squidGame.OZero
            }
            sender.isEnabled = false
        }
    }
    
    
    func checkForVictory(_ s :String) -> Bool
    {
        
        if (thisSymbol(one, s) && thisSymbol(two, s) && thisSymbol(three, s)) ||
            (thisSymbol(a, s) && thisSymbol(b, s) && thisSymbol(c, s)) ||
            (thisSymbol(alpha, s) && thisSymbol(beta, s) && thisSymbol(sigma, s)) ||
            (thisSymbol(one, s) && thisSymbol(a, s) && thisSymbol(alpha, s)) ||
            (thisSymbol(two, s) && thisSymbol(b, s) && thisSymbol(beta, s)) ||
            (thisSymbol(three, s) && thisSymbol(c, s) && thisSymbol(sigma, s)) ||
            (thisSymbol(one, s) && thisSymbol(b, s) && thisSymbol(sigma, s)) ||
            (thisSymbol(three, s) && thisSymbol(b, s) && thisSymbol(alpha, s))
        {
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let message = "\nNoughts " + String(zeroOScore) + "\n\nCrosses " + String(crossesScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
  
    @IBAction func resetGame(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            resetBoard()
            crossesScore = 0
            zeroOScore = 0
            crossXScore.text = "0"
            oZeroScore.text = "0"
        default:
            break
        }
    }
  
}

