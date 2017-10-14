//
//  EventSoon.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-25.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class EventSoon: Mappable {

    var eventID:String?
    var bestof:String?
    var fullDate:String?
    var img1Link:String?
    var img2Link:String?
    var linkID:String? {
        didSet {
            let alertProvider = AlertProvider()
            if let lastString = linkID!.components(separatedBy: "matches/").last,
                let matchID = lastString.components(separatedBy: "-").first {
                eventID = matchID
            }
            alertProvider.hasLocalNotification(byID: eventID ?? "") { (result) in
                self.hasNotification = result
            }
        }
    }
    var liveIn:String?
    var team1:String?
    var team2:String?
    var timeStamp:Double? {
        didSet {
            if timeStamp == 0 {
                eventDate = Date()
            } else {
                eventDate = Date(timeIntervalSince1970: timeStamp!)
            }
        }
    }
    var eventDate: Date?
    var hasNotification: Bool = false
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        bestof        <- map["bestof"]
        fullDate      <- map["fullDate"]
        img1Link      <- map["img1"]
        img2Link      <- map["img2"]
        linkID        <- map["linkID"]
        liveIn        <- map["liveIn"]
        team1         <- map["team1"]
        team2         <- map["team2"]
        timeStamp     <- map["timeStamp"]
    }
}
