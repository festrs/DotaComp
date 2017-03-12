//
//  DoneGamesTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-03-12.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class DoneGamesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radiantLabel: UILabel!
    @IBOutlet weak var direLabel: UILabel!
    @IBOutlet weak var bestOfLabel: UILabel!
    @IBOutlet weak var scoreTeam1: UILabel!
    @IBOutlet weak var scoreTeam2: UILabel!

    func setUpCellForEndedGame(doneGame: EventDone){
        radiantLabel.text = doneGame.team1
        direLabel.text = doneGame.team2
        
        bestOfLabel.text = "Best of \(doneGame.bestof!)"
    
        scoreTeam1.text = doneGame.score1.map { return "\($0)"} ?? ""
        scoreTeam2.text = doneGame.score2.map { return "\($0)"} ?? ""
    }

}
