//
//  GameViewController.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-25.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Kingfisher
import Chameleon

class GameViewController: UIViewController {
    @IBOutlet weak var radiantView: UIView!
    @IBOutlet weak var direView: UIView!
    @IBOutlet weak var radiantLabel: UILabel!
    @IBOutlet weak var direLabel: UILabel!
    var game:Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let direTeamTag = game.direTeam?.tag ?? game.direTeam?.teamName
        let radiantTeamTag = game.radiantTeam?.tag ?? game.radiantTeam?.teamName
        title = "\(direTeamTag!) VS \(radiantTeamTag!)"
        radiantLabel.text = game.radiantTeam?.teamName!
        direLabel.text = game.direTeam?.teamName!
        
        loadHeroImages()
        
        self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor.flatRedDark,UIColor.flatGreenDark])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        var frame = CGRect()
        frame.size = size
        if UIDevice.current.orientation.isLandscape {
            self.view.backgroundColor = GradientColor(.leftToRight, frame: frame, colors: [UIColor.flatRedDark,UIColor.flatGreenDark])
        } else {
            self.view.backgroundColor = GradientColor(.topToBottom, frame: frame, colors: [UIColor.flatRedDark,UIColor.flatGreenDark])
        }
    }
    
    func loadHeroImages() {
        let radiantPlayers = game.players?.filter {$0.team! == 0}
        let direPlayers = game.players?.filter {$0.team! == 1}
        
        for (index, player) in (radiantPlayers?.enumerated())! {
            if let imageView = self.view.viewWithTag(index+6) as? UIImageView{
                setImagePlayer(imageView: imageView,player: player)
            }
        }
        
        for (index, player) in (direPlayers?.enumerated())! {
            if let imageView = self.view.viewWithTag(index+1) as? UIImageView{
                setImagePlayer(imageView: imageView,player: player)
            }
        }

    }
    
    func setImagePlayer(imageView: UIImageView, player: Player) {
        let url = URL(string: player.heroImageUrl!)
        imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder_image"))
        addLabel(imageView: imageView, player: player)
    }
    
    func addLabel(imageView:UIImageView, player:Player) {
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height-21, width: 150, height: 21))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = player.name!
        imageView.addSubview(label)
        addLabelConstraints(label: label, superView: imageView)
    }
    
    func addLabelConstraints(label:UILabel, superView:UIView) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }
}
