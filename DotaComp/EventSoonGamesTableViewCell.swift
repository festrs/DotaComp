//
//  EventSoonGamesTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-03-08.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class EventSoonGamesTableViewCell: UITableViewCell {
    @IBOutlet weak var bestOfLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var direLabel: UILabel!
    @IBOutlet weak var radiantLabel: UILabel!

    func setUpCellForUpComingGame(upComingGame: EventSoon) {
        radiantLabel.text = upComingGame.team1
        direLabel.text = upComingGame.team2

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short

        if upComingGame.timeStamp == 0 {
            timeLabel.text = "LIVE NOW!"
        } else {
            timeLabel.text = dateFormatter.string(from: upComingGame.eventDate ?? Date())
        }

        bestOfLabel.text = "Best of \(upComingGame.bestof!)"

        if upComingGame.hasNotification {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .disclosureIndicator
        }
    }

}

extension String {
    var condensedWhitespace: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
