//
//  Team.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class Team: Mappable{
    
    var complete:Bool?
    var teamId:Int?
    var teamLogo:Int?
    var teamName:String?
    var tag:String?
    var logoUrl:String?
    var countryCode:String?

    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        complete        <- map["dire_series_wins"]
        teamId          <- map["team_id"]
        teamLogo        <- map["team_logo"]
        teamName        <- map["team_name"]
        tag             <- map["tag"]
        countryCode     <- map["country_code"]
        logoUrl         <- map["logo_url"]
    }
}
