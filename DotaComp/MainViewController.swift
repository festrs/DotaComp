//
//  ViewController.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var liveGames:[Game] = []
    var soonGames:[EventSoon] = []
    var doneGames:[EventDone] = []
    
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RequestUpCommingGamesError = "Error while requesting up coming games."
        static let RequestLiveGamesError = "Error while requesting live games."
        static let JSONParseError = "Error parsing JSON request."
    }
    
    struct Keys {
        static let Result = "result"
        static let Games = "games"
        static let NumberOfSections = 3
        static let liveGameCellIdentifier = "LiveGameCell"
        static let eventSoonCellIdentifier = "EventSoonCell"
        static let UpcomingGames = "eventSoon"
        static let DoneGames = "eventDone"
        static let sectionLiveTitle = "Live Games"
        static let sectionSoonTitle = "Upcoming Games"
        static let sectionDoneTitle = "Done Games"
        static let segueIdentifier = "toGame"
        static let LiveGamesURL = "http://watcherd2.herokuapp.com/livegames"
        static let UpCommingURL = "http://watcherd2.herokuapp.com/upcoming"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        loadLiveGames()
        loadUpcommingAndDoneGames()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUpcommingAndDoneGames(){
        Alamofire.request(Keys.UpCommingURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    self.showAlert(Alerts.JSONParseError, message: String(describing: Alerts.JSONParseError))
                    return
                }
                let eventSoon = responseJSON[Keys.UpcomingGames] as! [[String : Any]]
                self.soonGames = Mapper<EventSoon>().mapArray(JSONArray: eventSoon)!.filter {
                    $0.team1 != nil &&
                        $0.team2 != nil
                }
                
                let eventDone = responseJSON[Keys.DoneGames] as! [[String : Any]]
                
                self.doneGames = Mapper<EventDone>().mapArray(JSONArray: eventDone)!.filter {
                    $0.team1 != nil &&
                        $0.team2 != nil
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(Alerts.RequestUpCommingGamesError, message: String(describing: error))
            }
        }
    }
    
    func loadLiveGames(){
        Alamofire.request(Keys.LiveGamesURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                
                guard let responseJSON = response.result.value as? [String: AnyObject] else {
                    self.showAlert(Alerts.JSONParseError, message: String(describing: Alerts.JSONParseError))
                    return
                }
                
                let array = responseJSON[Keys.Result]!
                let games = array[Keys.Games] as! [[String : Any]]
                
                self.liveGames = Mapper<Game>().mapArray(JSONArray: games)!.filter {
                        $0.direTeam?.teamName != nil &&
                        $0.radiantTeam?.teamName != nil
                }
                self.tableView.reloadData()
            case .failure(let error):
                self.showAlert(Alerts.RequestLiveGamesError, message: String(describing: error))
            }
        }
    }
    
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Keys.segueIdentifier{
            if let indexPath = sender as? IndexPath,
                let vc = segue.destination as? GameViewController{
                vc.game = liveGames[indexPath.row]
            }
        }
    }
    
}

extension MainViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.performSegue(withIdentifier: Keys.segueIdentifier, sender: indexPath)
        }
    }
}

extension MainViewController: UITableViewDataSource  {
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch indexPath.section {
        case 0:
            return 44
        case 1:
            return 120
        case 2:
            return 44
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Keys.sectionLiveTitle
        case 1:
            return Keys.sectionSoonTitle
        case 2:
            return Keys.sectionDoneTitle
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return liveGames.count
        case 1:
            return soonGames.count
        case 2:
            return doneGames.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Keys.NumberOfSections;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.liveGameCellIdentifier, for: indexPath)
            let game = liveGames[indexPath.row]
            
            let direTeam = game.direTeam?.teamName.map({ $0 }) ?? ""
            let radiantTeam = game.radiantTeam?.teamName.map({ $0 }) ?? ""
            
            cell.textLabel?.text = "Game: \(direTeam) vs \(radiantTeam)"
            return cell
    
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.eventSoonCellIdentifier, for: indexPath) as! EventSoonTableViewCell
            let eventSoon = soonGames[indexPath.row]
            
            let direTeam = eventSoon.team1.map({ $0 }) ?? ""
            let radiantTeam = eventSoon.team2.map({ $0 }) ?? ""
            
            cell.team1Label.text = radiantTeam
            cell.team2Label.text = direTeam
            cell.timeLabel.text = eventSoon.fullDate
            cell.bestOfLabel.text = "Best of \(eventSoon.bestof)"
            
            return cell

        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.liveGameCellIdentifier, for: indexPath)
            let game = doneGames[indexPath.row]
            
            let direTeam = game.team1.map({ $0 }) ?? ""
            let radiantTeam = game.team2.map({ $0 }) ?? ""
            
            cell.textLabel?.text = "Game: \(direTeam) vs \(radiantTeam)"
            return cell
            

        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.liveGameCellIdentifier, for: indexPath)
            return cell
        }
    }
}
