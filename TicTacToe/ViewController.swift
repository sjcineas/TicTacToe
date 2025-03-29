//
//  ViewController.swift
//  TicTacToe
//
//  Created by Schadrack Cineas on 3/27/25.
//

import UIKit

class ViewController: UIViewController {
    enum Turn{
        case Nought
        case Cross
    }
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    var board = [UIButton]()
    var NOUGHT = "O"
    var CROSS = "X"
    var noughtScore = 0
    var crossScore = 0

    @IBAction func boardAction(_ sender: UIButton) {
        addToBoard(sender)
        if checkWinner(CROSS){
            crossScore += 1;
            resultAlert(title: "Crosses Win")
            
        }
        if checkWinner(NOUGHT){
            noughtScore += 1;
            resultAlert(title: "Nought Win")
        }
        if(fullBoard()){
            resultAlert(title: "Draw!")
        }
    }
    
    func addToBoard(_ sender:UIButton){
        if(sender.title(for: .normal) ==  nil){
            if(currentTurn == Turn.Nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
            }else if(currentTurn == Turn.Cross){
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    func resultAlert(title:String ){
        let message = "Score: \nNought: \(noughtScore)\nCross: \(crossScore)"
        let ac = UIAlertController(title: title, message:message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in self.resetBoard()}))
        self.present(ac, animated: true)
    }
    
    func resetBoard(){
        print("Start Reset")
        for button in board{
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        view.layoutIfNeeded()
        if firstTurn == Turn.Nought{
            firstTurn = Turn.Cross
            turnLabel.text = CROSS
        }else {
            firstTurn = Turn.Nought
            turnLabel.text = NOUGHT
        }
        currentTurn = firstTurn
        
        print("End Reset")
    }
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool{
        return button.title(for: .normal) == symbol
    }

    func checkWinner(_ s: String) -> Bool{
        //Horizontal Win
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s){
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s){
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s){
            return true
        }
        //Vertical Win
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s){
            return true
        }
        
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s){
            return true
        }
        
        //Diagonal Win
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s){
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s){
            return true
        }
        return false
    }
    
    func fullBoard() -> Bool{
        for button in board{
            if(button.title(for: .normal) == nil){
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
    }


}

