//
//  Faction.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class Faction: Mappable {
    
    var barracksState:Int?
    var score:Int?
    var towerState:Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        barracksState   <- map["barracks_state"]
        score           <- map["score"]
        towerState      <- map["tower_state"]
    }
}
