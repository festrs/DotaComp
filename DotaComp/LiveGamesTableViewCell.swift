//
//  EventSoonTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-27.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class LiveGamesTableViewCell: UITableViewCell {

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
    
    func setUpCell(liveGame: Game) {
        let direTeam = liveGame.direTeam?.teamName.map { $0 } ?? ""
        let radiantTeam = liveGame.radiantTeam?.teamName.map { $0 } ?? ""
        
        team1Label.text = radiantTeam
        team2Label.text = direTeam

        timeLabel.text = "LIVE"
        
        bestOfLabel.text = getSeriesType(seriesType: liveGame.seriesType!)
    }
    
    func getSeriesType(seriesType: Int) -> String {
        switch seriesType {
        case 0:
            return "Best of 1"
        case 1:
            return "Best of 3"
        case 2:
            return "Best of 5"
        default:
            return ""
        }
    }

}
