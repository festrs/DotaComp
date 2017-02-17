//
//  GameFoldingTableViewCell.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-02-15.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit

class GameFoldingTableViewCell: FoldingCell {

    @IBOutlet weak var assistLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    
    override func awakeFromNib() {
        
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        
        heroImageView.layer.cornerRadius = 10
        heroImageView.layer.masksToBounds = true
        
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }

}
