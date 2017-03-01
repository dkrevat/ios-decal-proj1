//
//  HangmanPhrases.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import Foundation

// How many allowed guesses there are before a game over.
let NUM_GUESSES = 6

class HangmanPhrases {
    
    var phrases : NSArray!

    // Word currently in play.
    var currWord : String = ""
    
    var currWordArray :  Array<String> = []
    
    // Current game state (contains "_" in place of discovered letters)
    var currGameState :  Array<String> = []
    
    // User's total user guesses
    var currGuesses: Array<String> = []
    
    // User's incorrect guesses.
    var wrongGuesses : Array<String> = []
    
    var hangmanState : Int = 1
    
    var winAlertCount : Int = 1
    var loseAlertCount : Int = 1

    
    // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
    init() {
        let path = Bundle.main.path(forResource: "phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
    }
    
    // Get random phrase from all available phrases
    func getRandomPhrase() -> String {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        return phrases.object(at: index) as! String
    }
    
    // Start a new game.
    func initGameState() {
        clearGame()
        setUpGameState()
    }
    
    
    /* Applies a guess to the gamestate. */
    func guess(userLetter: String) {
        if (userLetter.isEmpty) {
            return
        }
        let cleanLetter = santizeUserInput(userInput: userLetter)
        if (currGuesses.contains(cleanLetter)) {
            return
        } else if (currWordArray.contains(cleanLetter)) {
            applyCorrectGuess(letter: cleanLetter)
        } else {
            applyIncorrectGuess(letter: cleanLetter)
        }
    }
    
    func applyCorrectGuess(letter: String) {
        currGuesses.append(letter)
        for i in 0..<currWord.characters.count {
            if (currWordArray[i] == letter) {
                currGameState[i] = letter
            }
        }
        if (!checkWin()) {
            playGoodGuessSound()
        }
    }
    
    func applyIncorrectGuess(letter: String) {
        currGuesses.append(letter)
        wrongGuesses.append(letter)
        hangmanState += 1
        if (!checkLoss()) {
            playBadGuessSound()
        }
    }
    
    func santizeUserInput(userInput: String) -> String {
        // this is bad swift is  a bad language with no string indexing.
        var iJustNeedThisLetterPls : String = ""
        var isThisTheFirstCharacter : Bool = true
        for letter in userInput.characters {
            if (isThisTheFirstCharacter) {
                iJustNeedThisLetterPls = String(letter)
                isThisTheFirstCharacter = false
            }
        }
        return iJustNeedThisLetterPls.uppercased()
    }

    func checkLoss() -> Bool {
        return wrongGuesses.count == NUM_GUESSES
    }
    
    func checkWin() -> Bool {
        return !currGameState.contains("_")
    }
    
    func clearGame() {
        currGameState = []
        currWordArray = []
        currGuesses = []
        wrongGuesses = []
        hangmanState = 1
    }
    
    func setUpGameState() {
        currWord = getRandomPhrase()
        for letter in currWord.characters {
            if (String(letter) == " ") {
                currGameState.append(String(" "))
            } else {
                currGameState.append(String("_"))
            }
            currWordArray.append(String(letter))
        }
    }
    
    func getCurrWord() -> String {
        return currWord
    }
    
    func getCurrGameState() -> String{
        return currGameState.joined(separator: "  ")
    }
    
    func getCurrGuesses() -> String {
        return currGuesses.joined(separator: ", ")
    }
    
    func getWrongGuesses() -> String {
        let guesses : String = wrongGuesses.joined(separator: ", ")
        return "Incorrect guesses: " + guesses
    }
    
    func getHangmanImageName() -> String {
        return "hangman" + String(hangmanState)
    }
    
    func playBadGuessSound() {
        SystemSoundID.playSound(withFilename: "bad_guess_good_song.m4a")
    }
    
    func playGoodGuessSound() {
        SystemSoundID.playSound(withFilename: "good_guess_good_song.m4a")
    }
    
    func playWinSound() {
        SystemSoundID.playSound(withFilename: "win_good_song.m4a")

    }
    
    func playLoseSound() {
        SystemSoundID.playSound(withFilename: "lose_good_song.m4a")

    }
    
    func playIntroMusic() {
        SystemSoundID.playSound(withFilename: "intro_good_song.m4a")

    }
    
    func getWinAlert() -> Array<String> {
        let alert1 : Array<String> = ["You just saved Adam Levin's life.",   "Congratulations, you are a true fan.", "I know."]
        let alert2 : Array<String> = ["You're an Animal!", "Congratulations, you saved Adam Levine from certain death.", "Phew!"]
        let alert3 : Array<String> = ["Really cool", "It's really impressive how much you care about Maroon 5's Adam Levine.", "I  just love him so much."]
        
        if (winAlertCount == 1) {
            winAlertCount += 1
            return alert1
        }
        if (winAlertCount == 2) {
            winAlertCount += 1
            return alert2
        }
        if (winAlertCount == 3) {
            winAlertCount = 1
            return alert3
        }
        return []
    }
    
    func getLoseAlert() -> Array<String> {
        let alert1 : Array<String> = ["You Maroon'd Adam.", "You didn't save Adam Levine, you sick fuck. Beg for forgiveness.", "im sos sorry fuk shit shit fuk"]
        let alert2 : Array<String> = ["Not a true fan.",  "You're a real Jesse Carmichael, aren't you?", "yea."]
        let alert3 : Array<String> = ["You really hate Adam Levine, huh?", "What did Adam Levine ever do to you?", "Give me another chance."]
        
        if (loseAlertCount == 1) {
            loseAlertCount += 1
            return alert1
        }
        if (loseAlertCount == 2) {
            loseAlertCount += 1
            return alert2
        }
        if (loseAlertCount == 3) {
            loseAlertCount = 1
            return alert3
        }
        return []
    }

}



/// Framework used for sound playback (you can ignore the extension for this lab)
import AudioToolbox

extension SystemSoundID {
    static func playSound(withFilename filename: String) {
        var sound: SystemSoundID = 0
        if let soundURL = Bundle.main.url(forResource: filename, withExtension: nil) {
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &sound)
            AudioServicesPlaySystemSound(sound)
        }
    }
}
