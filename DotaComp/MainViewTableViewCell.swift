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
    @IBOutlet weak var tournamentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bestOfLabel.layer.cornerRadius = 5
        bestOfLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCellForLiveGame(liveGame: Game){
        let direTeam = liveGame.direTeam?.teamName.map({ $0 }) ?? ""
        let radiantTeam = liveGame.radiantTeam?.teamName.map({ $0 }) ?? ""
        
        team1Label.text = radiantTeam
        team2Label.text = direTeam
        bestOfLabel.backgroundColor = UIColor.flatRed()
        tournamentLabel.text = liveGame.tournamentName!
    }
    
    func setUpCellForUpComingGame(upComingGame: EventSoon){
        let direTeam = upComingGame.team1.map({ $0 }) ?? ""
        let radiantTeam = upComingGame.team2.map({ $0 }) ?? ""
        team1Label.text = radiantTeam
        team2Label.text = direTeam
        timeLabel.text = upComingGame.liveIn!
        bestOfLabel.text = "Best of \(upComingGame.bestof!)"
        bestOfLabel.backgroundColor = UIColor.flatRed()
    }
    
    func setUpCellForEndedGame(){
        
    }

}
