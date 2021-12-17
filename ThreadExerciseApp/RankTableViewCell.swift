//
//  RankTableViewCell.swift
//  ThreadExerciseApp
//
//  Created by 김주영 on 2021/12/17.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(cellData: Score) {
        rankLabel.text = "\(cellData.score) 개"
    }
}
