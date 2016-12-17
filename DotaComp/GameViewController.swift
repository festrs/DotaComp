//
//  GameViewController.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-25.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class GameViewController: UIViewController {
    
    var game:Game!

    override func viewDidLoad() {
        super.viewDidLoad()
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
                imageView.kf.setImage(with: url)
            }
            tag = tag + 1
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        loadHeroImages()
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
