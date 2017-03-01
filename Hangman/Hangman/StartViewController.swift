//
//  StartViewController.swift
//  Hangman
//
//  Created by Devyn Krevat on 2/25/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    let hangmanPhrases : HangmanPhrases = HangmanPhrases()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Play intro music.
        hangmanPhrases.playIntroMusic()
        backgroundImage.image = UIImage(named: "startBackgroundImage.jpg")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
