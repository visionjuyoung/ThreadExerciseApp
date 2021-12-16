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
}
