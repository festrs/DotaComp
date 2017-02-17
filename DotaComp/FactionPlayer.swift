//
//  FactionPlayer.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2017-02-15.
//  Copyright © 2017 Felipe Dias Pereira. All rights reserved.
//

import UIKit
import ObjectMapper

class FactionPlayer: Mappable {
    
    var accountId:Int?
    var assists:Int?
    var death:Int?
    var denies:Int?
    var gold:Int?
    var goldPerMin:Int?
    var heroId:Int?
    var item0:Int?
    var item1:Int?
    var item2:Int?
    var item3:Int?
    var item4:Int?
    var item5:Int?
    var kills:Int?
    var lastHits:Int?
    var level:Int?
    var netWorth:Int?
    var playerSlot:Int?
    var ultimateCooldown:Int?
    var ultimateState:Int?
    var xpPerMin:Int?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
         accountId          <- map["account_id"]
         assists            <- map["assists"]
         death              <- map["death"]
         denies             <- map["denies"]
         gold               <- map["gold"]
         goldPerMin         <- map["gold_per_min"]
         heroId             <- map["hero_id"]
         item0              <- map["item0"]
         item1              <- map["item1"]
         item2              <- map["item2"]
         item3              <- map["item3"]
         item4              <- map["item4"]
         item5              <- map["item5"]
         kills              <- map["kills"]
         lastHits           <- map["last_hits"]
         level              <- map["level"]
         netWorth           <- map["net_worth"]
         playerSlot         <- map["player_slot"]
         ultimateCooldown   <- map["ultimate_cooldown"]
         ultimateState      <- map["ultimate_state"]
         xpPerMin           <- map["xp_per_min"]
    }
}
