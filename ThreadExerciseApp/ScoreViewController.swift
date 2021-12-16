//
//  ScoreViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/15.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func restart(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
}
