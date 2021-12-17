//
//  InitialViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/15.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var ball1: UIView!
    @IBOutlet weak var ball2: UIView!
    @IBOutlet weak var ball3: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    
    func setUI() {
        let balls: [UIView] = [ball1, ball2, ball3]
        for ball in balls {
            ball.layer.cornerRadius = 40
        }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func rankButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RankViewController") as? RankViewController else { return }
        present(vc, animated: true, completion: nil)
    }
}
