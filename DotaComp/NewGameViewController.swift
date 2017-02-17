//
//  NewGameViewController.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-02-15.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Kingfisher

class NewGameViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let kCloseCellHeight: CGFloat = 154
    let kOpenCellHeight: CGFloat = 301
    let kRowsCount = 10

    var cellHeights = [CGFloat]()
    var game:Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCellHeightsArray()
        
        let direTeamTag = game.direTeam?.tag ?? game.direTeam?.teamName
        let radiantTeamTag = game.radiantTeam?.tag ?? game.radiantTeam?.teamName
        
        title = "\(radiantTeamTag!) x \(direTeamTag!)"
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "dotacomp-background"))
        tableView.backgroundView?.addBlurEffect()
    }
    
    // MARK: configure
    func createCellHeightsArray() {
        for _ in 0...kRowsCount {
            cellHeights.append(kCloseCellHeight)
        }
    }
}


extension NewGameViewController : UITableViewDataSource {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as GameFoldingTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = UIColor.clear
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! GameFoldingTableViewCell
        
        var factionPlayer:FactionPlayer? = nil
        
        if indexPath.row <= 4{
            cell.foregroundView.backgroundColor = UIColor.flatForestGreen()
            factionPlayer = game.scoreboard?.radiant?.players?[indexPath.row]
            
        }else{
            cell.foregroundView.backgroundColor = UIColor.flatMaroon()
            factionPlayer = game.scoreboard?.dire?.players?[indexPath.row-5]
        }
        
        guard factionPlayer != nil else{
            return cell
        }
        
        let player = game.players?.first {
            $0.accountId == factionPlayer?.accountId
        }
        
        guard let url = URL(string: (player?.heroImageUrl!)!) else {
            return cell
        }
        
        cell.killsLabel.text = factionPlayer?.kills?.description
        cell.deathsLabel.text = factionPlayer?.death?.description
        cell.assistLabel.text = factionPlayer?.death?.description
        
        cell.heroImageView.kf.setImage(with: url, placeholder: UIImage(named: "Placeholder"))
        cell.playerName.text = player?.name!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[(indexPath as NSIndexPath).row]
    }
}

extension NewGameViewController : UITableViewDelegate {
    // MARK: Table vie delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight { // open cell
            cellHeights[(indexPath as NSIndexPath).row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {// close cell
            cellHeights[(indexPath as NSIndexPath).row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }

}
