//
//  EventSoonTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-27.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class MainViewTableViewCell: UITableViewCell {

    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var bestOfLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 8
        backView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCellForLiveGame(liveGame: Game){
        let direTeam = liveGame.direTeam?.teamName.map({ $0 }) ?? ""
        let radiantTeam = liveGame.radiantTeam?.teamName.map({ $0 }) ?? ""
        
        team1Label.text = radiantTeam
        team2Label.text = direTeam
        bestOfLabel.isHidden = true
        
        timeLabel.isHidden = false
        timeLabel.text = "LIVE"
        timeLabel.layer.cornerRadius = 2
        timeLabel.layer.masksToBounds = true
        timeLabel.backgroundColor = UIColor.flatForestGreen()
        timeLabel.textColor = UIColor.white
    }
    
    func setUpCellForUpComingGame(upComingGame: EventSoon){
        let direTeam = upComingGame.team1.map({ $0 }) ?? ""
        let radiantTeam = upComingGame.team2.map({ $0 }) ?? ""
        team1Label.text = radiantTeam
        team2Label.text = direTeam
        
        timeLabel.isHidden = false
        timeLabel.text = "Live in \(upComingGame.liveIn!)"
        timeLabel.layer.cornerRadius = 0
        timeLabel.layer.masksToBounds = false
        timeLabel.backgroundColor = UIColor.clear
        
        bestOfLabel.text = "Best of \(upComingGame.bestof!)"
        bestOfLabel.isHidden = false
    }
    
    func setUpCellForEndedGame(endedGame: EventDone){
        let direTeam = endedGame.team1.map({ $0 }) ?? ""
        let radiantTeam = endedGame.team2.map({ $0 }) ?? ""
        team1Label.text = radiantTeam
        team2Label.text = direTeam
        
        timeLabel.isHidden = true

        bestOfLabel.text = "Best of \(endedGame.bestof!)"
        bestOfLabel.isHidden = false
        
        self.selectionStyle = .none
    }

}
