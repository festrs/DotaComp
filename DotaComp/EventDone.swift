//
//  EventDone.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-25.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class EventDone: Mappable {
    
    var bestof:String?
    var fullDate:String?
    var img1Link:String?
    var img2Link:String?
    var linkID:String?
    var score1:String?
    var score2:String?
    var team1:String?
    var team2:String?
    var timeStamp:Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        bestof        <- map["bestof"]
        fullDate      <- map["fullDate"]
        img1Link      <- map["img1"]
        img2Link      <- map["img2"]
        linkID        <- map["linkID"]
        score1        <- map["score1"]
        score1        <- map["score2"]
        team1         <- map["team1"]
        team2         <- map["team2"]
        timeStamp     <- map["timeStamp"]
    }
}
