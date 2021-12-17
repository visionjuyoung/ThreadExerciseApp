//
//  ScoreViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/15.
//

import UIKit
import RealmSwift

class ScoreViewController: UIViewController {
    
    var realm: Realm!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score)"
        
        realm = try! Realm()
        var rank = Score.init(score: score)
        try! realm.write{
            realm.add(rank)
        }
    }
    
    @IBAction func restart(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func homeButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "InitialViewController") as? InitialViewController else { return }
        present(vc, animated: true, completion: nil)
    }
}
