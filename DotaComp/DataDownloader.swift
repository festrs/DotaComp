//
//  DataDownloader.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-02-13.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class DataDownloader: NSObject {
    public var liveGames:[Game] = []
    public var soonGames:[EventSoon] = []
    public var doneGames:[EventDone] = []
    
    enum DataDownloaderErrors: Error {
        case JSONParseError
        case AlamoFireError
    }
    
    struct Keys {
        static let LiveGamesURL = "https://dotacomp-service.herokuapp.com/api/livegames/true"
        static let UpCommingGamesURL = "https://dotacomp-service.herokuapp.com/api/upcominggames"
        static let EndedGamesURL = "https://dotacomp-service.herokuapp.com/api/endedgames"
    }
    
    func updateData(_ completion:@escaping (_ error: Error?) ->Void ) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        downloadJSON(url: Keys.LiveGamesURL) { (resultJSON, error) in
            if error != nil{
                completion(error)
            }else{
                self.liveGames = Mapper<Game>().mapArray(JSONArray: resultJSON!)!
            }
            print("updated live games");
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        downloadJSON(url: Keys.UpCommingGamesURL) { (resultJSON, error) in
            if error != nil{
                completion(error)
            }else{
                self.soonGames = Mapper<EventSoon>().mapArray(JSONArray: resultJSON!)!
            }
            print("updated up comming games");
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        downloadJSON(url: Keys.EndedGamesURL) { (resultJSON, error) in
            if error != nil{
                completion(error)
            }else{
                self.doneGames = Mapper<EventDone>().mapArray(JSONArray: resultJSON!)!.filter {
                    $0.team1 != nil &&
                        $0.team2 != nil
                }
            }
            print("updated ended");
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion(nil);
        }
        
    }
    
    func downloadJSON(url: String ,_ completion:@escaping (_ result:[[String: Any]]?,_ error: Error?) ->Void ){
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let responseJSON = response.result.value as? [AnyObject] else {
                    completion(nil,DataDownloaderErrors.JSONParseError)
                    return
                }
                let result = responseJSON as! [[String : Any]]
                completion(result, nil)
            case .failure(_):
                completion(nil,DataDownloaderErrors.AlamoFireError);
            }
        }
    }
    

}
