//
//  ViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextBallView: UIView!
    @IBOutlet weak var centerBallView: UIView!
    @IBOutlet weak var ball1: UIView!
    @IBOutlet weak var ball2: UIView!
    @IBOutlet weak var ball3: UIView!
    @IBOutlet weak var ball4: UIView!
    @IBOutlet weak var ball5: UIView!
    @IBOutlet weak var ball6: UIView!
    @IBOutlet weak var ball7: UIView!
    @IBOutlet weak var ball8: UIView!
    @IBOutlet weak var ballLayerX: NSLayoutConstraint!
    @IBOutlet weak var ballLayerY: NSLayoutConstraint!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var swipeLog = 0
    
    enum BallColor: Int {
        case red = 0
        case blue = 1
        case yellow = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSwipe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameStart()
    }
    
    func setView() {
        let balls : [UIView] = [ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8]
        
        nextBallView.layer.borderWidth = 1
        nextBallView.layer.borderColor = UIColor.black.cgColor
        nextBallView.layer.cornerRadius = 10
        
        centerBallView.layer.cornerRadius = 50
        
        for ball in balls {
            ball.layer.cornerRadius = 20
        }
    }
    
    func setSwipe() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(move))
        left.direction = .left
        let right = UISwipeGestureRecognizer(target: self, action: #selector(move))
        right.direction = .right
        let down = UISwipeGestureRecognizer(target: self, action: #selector(move))
        down.direction = .down
        
        centerBallView.addGestureRecognizer(left)
        centerBallView.addGestureRecognizer(right)
        centerBallView.addGestureRecognizer(down)
    }
    
    @objc func move(sender: UIGestureRecognizer){
        guard let swipe = sender as? UISwipeGestureRecognizer else {
            return
        }
        
        switch swipe.direction {
        case UISwipeGestureRecognizer.Direction.left:
            ballLayerX.constant = ballLayerX.constant - 200
            print("left")
            swipeLog = 0
        case UISwipeGestureRecognizer.Direction.right:
            ballLayerX.constant = ballLayerX.constant + 200
            print("right")
            swipeLog = 1
        case UISwipeGestureRecognizer.Direction.down:
            ballLayerY.constant = ballLayerY.constant + 200
            print("down")
            swipeLog = 2
        default:
            return
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setColor() {
        let balls : [UIView] = [ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8]
        for ball in balls {
            let color = Int.random(in: 0...2)
            switch color {
            case BallColor.red.rawValue:
                ball.backgroundColor = .red
            case BallColor.blue.rawValue:
                ball.backgroundColor = .blue
            case BallColor.yellow.rawValue:
                ball.backgroundColor = .yellow
            default:
                return
            }
        }
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            print("end")
        }
    }
    
    func setTimer() {
        totalTime = 60
        timer.invalidate()
        secondsPassed = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    func gameStart() {
        setColor()
        progressBar.progress = 0.0
        setTimer()
    }
}

