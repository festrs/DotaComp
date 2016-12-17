//
//  Scoreboard.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class Scoreboard: Mappable {

    var duration:Int?
    var roshanRespawnTimer:Int?
    var dire:Faction?
    var radiant:Faction?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        duration                <- map["duration"]
        roshanRespawnTimer      <- map["roshan_respawn_timer"]
        dire                    <- map["dire"]
        radiant                 <- map["radiant"]
    }
}
