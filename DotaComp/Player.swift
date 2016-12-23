//
//  Player.swift
//  DotaComp
//
//  Created by Felipe Dias Pereira on 2016-10-26.
//  Copyright © 2016 Felipe Dias Pereira. All rights reserved.
//

import ObjectMapper

class Player: Mappable {
    
    var accountId:Int?
    var heroId:Int?
    
    //    0 - Radiant
    //    1 - Dire
    //    2 - Broadcaster
    //    4 - Unassigned
    var team:Int?
    
    var name:String?
    var heroImageUrl:String?
    private static let baseURL = "http://cdn.dota2.com/apps/dota2/images/heroes/"
    
    required init?(map: Map) {
        heroImageUrl = Player.baseURL + getHeroName(heroID: map.JSON["hero_id"]! as! Int)
    }
    
    // Mappable
    func mapping(map: Map) {
        accountId       <- map["account_id"]
        heroId          <- map["hero_id"]
        name            <- map["name"]
        team            <- map["team"]
    }
}


func getHeroName(heroID: Int) -> String
{
    switch (heroID) {
    case 1: return "antimage_full.png"; 
    case 2: return "axe_full.png"; 
    case 3: return "bane_full.png"; 
    case 4: return "bloodseeker_full.png"; 
    case 5: return "crystal_maiden_full.png"; 
    case 6: return "drow_ranger_full.png"; 
    case 7: return "earthshaker_full.png"; 
    case 8: return "juggernaut_full.png"; 
    case 9: return "mirana_full.png"; 
    case 11: return "nevermore_full.png"; 
    case 10: return "morphling_full.png"; 
    case 12: return "phantom_lancer_full.png"; 
    case 13: return "puck_full.png"; 
    case 14: return "pudge_full.png"; 
    case 15: return "razor_full.png"; 
    case 16: return "sand_king_full.png"; 
    case 17: return "storm_spirit_full.png"; 
    case 18: return "sven_full.png"; 
    case 19: return "tiny_full.png"; 
    case 20: return "vengefulspirit_full.png"; 
    case 21: return "windrunner_full.png"; 
    case 22: return "zuus_full.png"; 
    case 23: return "kunkka_full.png"; 
    case 25: return "lina_full.png"; 
    case 31: return "lich_full.png"; 
    case 26: return "lion_full.png"; 
    case 27: return "shadow_shaman_full.png"; 
    case 28: return "slardar_full.png"; 
    case 29: return "tidehunter_full.png"; 
    case 30: return "witch_doctor_full.png"; 
    case 32: return "riki_full.png"; 
    case 33: return "enigma_full.png"; 
    case 34: return "tinker_full.png"; 
    case 35: return "sniper_full.png"; 
    case 36: return "necrolyte_full.png"; 
    case 37: return "warlock_full.png"; 
    case 38: return "beastmaster_full.png"; 
    case 39: return "queenofpain_full.png"; 
    case 40: return "venomancer_full.png"; 
    case 41: return "faceless_void_full.png"; 
    case 42: return "skeleton_king_full.png"; 
    case 43: return "death_prophet_full.png"; 
    case 44: return "phantom_assassin_full.png"; 
    case 45: return "pugna_full.png"; 
    case 46: return "templar_assassin_full.png"; 
    case 47: return "viper_full.png"; 
    case 48: return "luna_full.png"; 
    case 49: return "dragon_knight_full.png"; 
    case 50: return "dazzle_full.png"; 
    case 51: return "rattletrap_full.png"; 
    case 52: return "leshrac_full.png"; 
    case 53: return "furion_full.png"; 
    case 54: return "life_stealer_full.png"; 
    case 55: return "dark_seer_full.png"; 
    case 56: return "clinkz_full.png"; 
    case 57: return "omniknight_full.png"; 
    case 58: return "enchantress_full.png"; 
    case 59: return "huskar_full.png"; 
    case 60: return "night_stalker_full.png"; 
    case 61: return "broodmother_full.png"; 
    case 62: return "bounty_hunter_full.png"; 
    case 63: return "weaver_full.png"; 
    case 64: return "jakiro_full.png"; 
    case 65: return "batrider_full.png"; 
    case 66: return "chen_full.png"; 
    case 67: return "spectre_full.png"; 
    case 69: return "doom_bringer_full.png"; 
    case 68: return "ancient_apparition_full.png"; 
    case 70: return "ursa_full.png"; 
    case 71: return "spirit_breaker_full.png"; 
    case 72: return "gyrocopter_full.png"; 
    case 73: return "alchemist_full.png"; 
    case 74: return "invoker_full.png"; 
    case 75: return "silencer_full.png"; 
    case 76: return "obsidian_destroyer_full.png"; 
    case 77: return "lycan_full.png"; 
    case 78: return "brewmaster_full.png"; 
    case 79: return "shadow_demon_full.png"; 
    case 80: return "lone_druid_full.png"; 
    case 81: return "chaos_knight_full.png"; 
    case 82: return "meepo_full.png"; 
    case 83: return "treant_full.png"; 
    case 84: return "ogre_magi_full.png"; 
    case 85: return "undying_full.png"; 
    case 86: return "rubick_full.png"; 
    case 87: return "disruptor_full.png"; 
    case 88: return "nyx_assassin_full.png"; 
    case 89: return "naga_siren_full.png"; 
    case 90: return "keeper_of_the_light_full.png"; 
    case 91: return "wisp_full.png"; 
    case 92: return "visage_full.png"; 
    case 93: return "slark_full.png"; 
    case 94: return "medusa_full.png"; 
    case 95: return "troll_warlord_full.png"; 
    case 96: return "centaur_full.png"; 
    case 97: return "magnataur_full.png"; 
    case 98: return "shredder_full.png"; 
    case 99: return "bristleback_full.png"; 
    case 100: return "tusk_full.png"; 
    case 101: return "skywrath_mage_full.png"; 
    case 102: return "abaddon_full.png"; 
    case 103: return "elder_titan_full.png"; 
    case 104: return "legion_commander_full.png"; 
    case 105: return "techies_full.png"; 
    case 106: return "ember_spirit_full.png"; 
    case 107: return "earth_spirit_full.png"; 
    case 108: return "abyssal_underlord_full.png"; 
    case 109: return "terrorblade_full.png"; 
    case 110: return "phoenix_full.png"; 
    case 111: return "oracle_full.png"; 
    case 112: return "winter_wyvern_full.png"; 
    case 113: return "arc_warden_full.png"; 
    default:
        return "PlaceholderDraft.png";
        
    }
}
