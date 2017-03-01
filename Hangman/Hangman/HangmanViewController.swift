//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    let hangmanPhrases : HangmanPhrases = HangmanPhrases()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Load up initial game.
        startGame()
         backgroundImage.image = UIImage(named: "background.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var userEntry: UITextField!
    
    @IBOutlet weak var incorrectGuesses: UILabel!
    
    @IBOutlet weak var wordToGuess: UILabel!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        startGame()
    }

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var hangmanPic: UIImageView!
    
    // lil bloated huh.
    @IBAction func guessButton(_ sender: UIButton) {
        hangmanPhrases.guess(userLetter: userEntry.text!)
        wordToGuess.text = hangmanPhrases.getCurrGameState()
        incorrectGuesses.text = hangmanPhrases.getWrongGuesses()
        hangmanPic.image = UIImage(named: hangmanPhrases.getHangmanImageName())
        userEntry.text = nil
        if (hangmanPhrases.checkWin()) {
            hangmanPhrases.playWinSound()
            let hangmanAlert : Array<String> = hangmanPhrases.getWinAlert()
            let alert = UIAlertController(title:hangmanAlert[0], message: hangmanAlert[1], preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: hangmanAlert[2], style: UIAlertActionStyle.default,  handler: {action in self.startGame()}))
            self.present(alert, animated: true, completion: nil)
        } else if (hangmanPhrases.checkLoss()) {
            hangmanPhrases.playLoseSound()
            let hangmanAlert : Array<String> = hangmanPhrases.getLoseAlert()
            let alert = UIAlertController(title: hangmanAlert[0], message: hangmanAlert[1], preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: hangmanAlert[2], style: UIAlertActionStyle.default,  handler: {action in self.startGame()}))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func startGame() {
        hangmanPhrases.initGameState()
        wordToGuess.text = hangmanPhrases.getCurrGameState()
        incorrectGuesses.text = hangmanPhrases.getWrongGuesses()
        hangmanPic.image = UIImage(named: hangmanPhrases.getHangmanImageName())
        userEntry.text = nil
    }
    

}
