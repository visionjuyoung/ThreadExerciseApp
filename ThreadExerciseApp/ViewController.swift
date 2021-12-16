//
//  ViewController.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/13.
//

import UIKit
import AVFoundation

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
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var score: UILabel!
    
    
    var player: AVAudioPlayer?
    
    var initialFrame: CGPoint = CGPoint(x: 0, y: 0)
    var currentBalls: [UIView] = []
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var swipeLog = 0
    var count = 0
    var sum: Int = 0
    
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
            getSwipeGesture(location: ballLayerX.constant, xy: 0)
            swipeLog = 0
        case UISwipeGestureRecognizer.Direction.right:
            ballLayerX.constant = ballLayerX.constant + 200
            getSwipeGesture(location: ballLayerX.constant, xy: 0)
            swipeLog = 1
        case UISwipeGestureRecognizer.Direction.down:
            ballLayerY.constant = ballLayerY.constant + 200
            getSwipeGesture(location: ballLayerY.constant, xy: 1)
            swipeLog = 2
        default:
            return
        }
        
        
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.ballLayerX.constant = 0.0
            self.ballLayerY.constant = 200.0
        })
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
        currentBalls = balls
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let minute: Int = 60
            TimeLabel.text = "\(minute - secondsPassed)"
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController else {
                return
            }
            vc.score = sum
            present(vc, animated: true, completion: nil)
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
        centerBallView.backgroundColor = ball1.backgroundColor
    }
    
    func getSwipeGesture(location: CGFloat, xy: Int) {
        let balls : [UIView] = [ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8]
        if xy == 0, location > 150 {
            if balls[count].backgroundColor  == . blue {
                balls[count].backgroundColor = .black
                count += 1
                sum += 1
            }
        } else if xy == 0, location < -150 {
            if balls[count].backgroundColor  == . red {
                balls[count].backgroundColor = .black
                count += 1
                sum += 1
            }
        } else if xy == 1, location > 300 {
            if balls[count].backgroundColor  == . yellow {
                balls[count].backgroundColor = .black
                count += 1
                sum += 1
            }
        }
        
        if count == balls.count {
            setColor()
            count = 0
        }
        centerBallView.backgroundColor = balls[count].backgroundColor
        score.text = "맞춘 개수 : \(sum)"
    }
    
    func playSound() {
        
    }
}

