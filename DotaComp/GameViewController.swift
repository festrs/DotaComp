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
    
    @IBOutlet weak var clockBarButton: UIBarButtonItem!
    var game:Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\((game.direTeam?.teamName)!) x \((game.radiantTeam?.teamName)!)"
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in 
            self.clockBarButton.title = "\(((self.game.scoreboard?.duration)!/60))"
            
        })
        loadHeroImages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadHeroImages(){
        let players = game.players?.filter {$0.team! <= 1}
        var tag = 1
        for player in players!{
            if let imageView = self.view.viewWithTag(tag) as? UIImageView{
                let url = URL(string: player.heroImageUrl!)
                imageView.kf.setImage(with: url, placeholder: UIImage(named: "Placeholder"))
                addLabel(imageView: imageView, player: player)
            }
            tag = tag + 1
        }
    }
    
    func addLabel(imageView:UIImageView, player:Player){
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.height-21, width: 150, height: 21))
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = player.name!
        imageView.addSubview(label)
        addLabelConstraints(label: label, superView: imageView)
    }
    
    func addLabelConstraints(label:UILabel, superView:UIView){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        label.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
