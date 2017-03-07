//
//  Game.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-20.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class Game : Mappable{
    
    var direSeriesWins:Int?
    var gameNnumber:Int?
    var stageName:String?
    var leagueGameId:Int?
    var leagueId:Int?
    var leagueSeriesId:Int?
    var leagueTier:Int?
    var lobbyId:Int?
    var matchId:Int?
    var radiantSeriesWins:Int?
    var seriesId:Int?
    var tournamentName:String?
    
    // 0 = best of 2
    // 1 = best of 3
    // 2 = best of 5
    var seriesType:Int?
    var spectators:Int?
    var streamDelayS:Int?
    var direTeam:Team?
    var radiantTeam:Team?
    var scoreboard:Scoreboard?
    var players:[Player]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        direSeriesWins      <- map["dire_series_wins"]
        gameNnumber         <- map["game_number"]
        stageName           <- map["stage_name"]
        leagueGameId        <- map["league_game_id"]
        leagueId            <- map["league_id"]
        leagueSeriesId      <- map["league_series_id"]
        leagueTier          <- map["league_tier"]
        lobbyId             <- map["lobby_id"]
        matchId             <- map["match_id"]
        radiantSeriesWins   <- map["radiant_series_wins"]
        seriesId            <- map["series_id"]
        seriesType          <- map["series_type"]
        spectators          <- map["spectators"]
        streamDelayS        <- map["stream_delay_s"]
        direTeam            <- map["dire_team"]
        radiantTeam         <- map["radiant_team"]
        scoreboard          <- map["scoreboard"]
        players             <- map["players"]
        tournamentName      <- map["tournament_name"]
    }


}
