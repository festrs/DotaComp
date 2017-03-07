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
import Chameleon


extension UIView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var refreshImageView: UIImageView!
    var dataDownloader = DataDownloader()
    var activityIndicatorView: UIActivityIndicatorView!
    
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let DataDownloaderError = "Error while data downloading."
    }
    
    struct Keys {
        static let NumberOfSections = 3
        static let MainCellHeight = 76
        static let MainCellIdentifier = "MainCell"
        static let GamesLiveCellIdentifier = "LiveGamesCell"
        static let eventSoonCellIdentifier = "EventSoonCell"
        static let sectionLiveTitle = "Live Games"
        static let sectionSoonTitle = "Upcoming Games"
        static let sectionDoneTitle = "Done Games"
        static let segueIdentifier = "toGame"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        title = "Games"
        configRefreshControl()
        reloadData()
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = activityIndicatorView

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataDownloader.liveGames.count == 0 &&
            dataDownloader.soonGames.count == 0 &&
            dataDownloader.doneGames.count == 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            activityIndicatorView.startAnimating()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.clear
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        
        var images:[UIImage] = []
        
        for i in (0...15).reversed(){
            images.append(UIImage(named: "\(i)")!)
        }
        refreshImageView = UIImageView(image: UIImage(named: "14"))
        refreshImageView.backgroundColor = UIColor.clear
        refreshImageView.animationImages = images
        refreshImageView.animationDuration = 2
        
        refreshControl.addSubview(refreshImageView)
        
        tableView.addSubview(refreshControl)
    }
    
    func refresh(sender:AnyObject) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            guard let refresher = sender as? UIRefreshControl else {
                return
            }
            if(refresher.isRefreshing){
                self.reloadData()
            }
        })
    }
    
    func reloadData(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.dataDownloader.updateData(){
            error in
            if error != nil {
                self.showAlert(Alerts.DataDownloaderError, message: String(describing: error))
            }
            self.stopRefreshing()
        }
    }
    
    func stopRefreshing(){
        tableView.reloadData();
        refreshImageView.stopAnimating()
        refreshControl.endRefreshing()
        activityIndicatorView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
                vc.game = dataDownloader.liveGames[indexPath.row]
            }
        }
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Get the current size of the refresh controller
        var refreshBounds = self.refreshControl!.bounds;
        
        // Distance the table has been pulled >= 0
        let pullDistance = max(0.0, -self.refreshControl!.frame.origin.y);
        
        // Half the width of the table
        let midX = self.tableView.frame.size.width / 2.0;
        
        // Calculate the pull ratio, between 0.0-1.0
        //let pullRatio = min( max(pullDistance, 0.0), 100.0) / 100.0;
        
        // Calculate the width and height of our graphics
        let imageViewHeight = self.refreshImageView.bounds.size.height;
        let imageViewWidth = self.refreshImageView.bounds.size.width;
        
        // Set the Y coord of the graphics, based on pull distance
        let imageViewY = pullDistance - ( imageViewHeight);
        let imageViewX = midX - imageViewWidth / 2.0;
        
        // Set the graphic's frames
        var imageViewFrame = self.refreshImageView.frame;
        imageViewFrame.origin.x = imageViewX
        imageViewFrame.origin.y = imageViewY;
        
        refreshImageView.frame = imageViewFrame;
        
        // Set the encompassing view's frames
        refreshBounds.size.height = pullDistance;
        
        // If we're refreshing and the animation is not playing, then play the animation
        if (refreshControl!.isRefreshing && !refreshImageView.isAnimating) {
            refreshImageView.startAnimating()
        }
        
        //print("pullDistance \(pullDistance), pullRatio: \(pullRatio), midX: \(midX), refreshing: \(self.refreshControl!.isRefreshing)")
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.performSegue(withIdentifier: Keys.segueIdentifier, sender: indexPath)
        } else if indexPath.section == 1{
            let upComingGame = dataDownloader.soonGames[indexPath.row]
            if let url = URL(string: upComingGame.linkID!) {
                UIApplication.shared.open(url, options: [:]) {
                    boolean in
    
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource  {
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(Keys.MainCellHeight)
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
            return dataDownloader.liveGames.count
        case 1:
            return dataDownloader.soonGames.count
        case 2:
            return dataDownloader.doneGames.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.GamesLiveCellIdentifier, for: indexPath) as! LiveGamesTableViewCell
            let game = dataDownloader.liveGames[indexPath.row]
            cell.setUpCell(liveGame: game)
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.GamesLiveCellIdentifier, for: indexPath) as! LiveGamesTableViewCell
            let eventSoon = dataDownloader.soonGames[indexPath.row]
            //cell.setUpCellForUpComingGame(upComingGame: eventSoon)
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.GamesLiveCellIdentifier, for: indexPath) as! LiveGamesTableViewCell
            let eventDone = dataDownloader.doneGames[indexPath.row]
            //cell.setUpCellForEndedGame(endedGame: eventDone)
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.GamesLiveCellIdentifier, for: indexPath)
            return cell
        }
    }
}
