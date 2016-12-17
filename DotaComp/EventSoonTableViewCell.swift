//
//  EventSoonTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-27.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class EventSoonTableViewCell: UITableViewCell {

    @IBOutlet weak var team1Label: UILabel!
    @IBOutlet weak var team2Label: UILabel!
    @IBOutlet weak var bestOfLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
