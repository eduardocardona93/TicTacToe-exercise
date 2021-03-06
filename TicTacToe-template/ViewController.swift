//
//  ViewController.swift
//  TicTacToe-template
//
//  Created by Mohammad Kiani on 2020-06-08.
//  Copyright © 2020 mohammadkiani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var crossTurn = true
    var gameOver = false
    var crossTags:[Int] = []
    var noughtTags:[Int] = []
    let boardWins=[
        // Horizontal Wins
        [1,2,3],[4,5,6],[7,8,9],
        // Vertical Wins
        [1,4,7],[2,5,8],[3,6,9],
        // Diagonal Wins
        [1,5,9],[3,5,7]
        ]
    @IBOutlet weak var winnerLbl: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    @IBOutlet weak var boardImg: UIImageView!
    //Row 1
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    //Row 2
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    //Row 3
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideInClick()
        setStartGame()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func playAgainBtn(_ sender: UIButton) {
        setStartGame()

    }
    func setStartGame(){
        playAgainBtn.alpha = 0
        crossTags.removeAll()
        noughtTags.removeAll()
        btn1.setImage(nil, for: [])
        btn2.setImage(nil, for: [])
        btn3.setImage(nil, for: [])
        btn4.setImage(nil, for: [])
        btn5.setImage(nil, for: [])
        btn6.setImage(nil, for: [])
        btn7.setImage(nil, for: [])
        btn8.setImage(nil, for: [])
        btn9.setImage(nil, for: [])
        crossTurn = true
        winnerLbl.text = ""
        gameOver = false
    }
    func setGameOver(message:String){
        winnerLbl.text = message
        gameOver = true
        UIView.animate(withDuration: 1){
            self.playAgainBtn.alpha = 1
        }
        fromCenter(sender: playAgainBtn)

    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if !gameOver{
            if !noughtTags.contains(sender.tag) && !crossTags.contains(sender.tag) {
                if crossTurn {
                    crossTurn = false
                    crossTags.append(sender.tag)
                    sender.setImage(UIImage(named: "cross.png"), for: [])
                    slideFromTop(sender: sender)
                    for array in boardWins {
                        if crossTags.contains(array[0]) && crossTags.contains(array[1]) && crossTags.contains(array[2]){
                            setGameOver(message: "Cross wins")
                            break
                        }
                    }
                } else {
                    crossTurn = true
                    noughtTags.append(sender.tag)
                    sender.setImage(UIImage(named: "nought.png"), for: [])
                    rotate(sender: sender)
                    for array in boardWins {
                        if noughtTags.contains(array[0]) && noughtTags.contains(array[1]) && noughtTags.contains(array[2]) {
                            setGameOver(message:"Nought wins")
                            break
                        }
                    }
                }
            }
            if noughtTags.count + crossTags.count == 9 && !gameOver{
                setGameOver(message:"No winner")
            }
        }

        
        
        
    }
    func slideFromTop(sender: UIButton){
        sender.transform = CGAffineTransform(translationX: 0, y: -100)
        UIView.animate(withDuration: 1){
            sender.transform = CGAffineTransform.identity
        }
    }
    func rotate(sender: UIButton){
        UIView.animate(withDuration: 2){
            sender.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
    }
    func fromCenter(sender: UIButton){
        UIView.animate(withDuration: 1){
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } completion: { _ in
            UIView.animate(withDuration: 2){
                sender.transform = CGAffineTransform.identity
            }
        }
    }
    func growClick(sender: UIButton) {
        let width = sender.frame.size.width
        let height = sender.frame.size.height
        
        let x = sender.frame.origin.x
        let y = sender.frame.origin.y
        
        sender.frame = CGRect(x: x , y: y, width: 0, height: 0)
        UIView.animate(withDuration: 2){
            sender.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    func slideInClick() {
        gameOver = true
        boardImg.center = CGPoint(x: boardImg.center.x - 100, y: boardImg.center.y)
        UIView.animate(withDuration: 3){
            
            self.boardImg.center = CGPoint(x: self.boardImg.center.x + 100, y: self.boardImg.center.y)
            self.gameOver = false
            
        }
    }
}

