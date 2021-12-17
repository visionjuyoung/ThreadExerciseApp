//
//  Score.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/17.
//

import Foundation
import RealmSwift

class Score: Object {
    @objc dynamic var score: Int = 0
    
    convenience init(score: Int) {
        self.init()
        self.score = score
    }
}
