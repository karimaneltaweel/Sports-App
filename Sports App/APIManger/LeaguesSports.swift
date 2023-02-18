//
//  ChampionLeagesAPi.swift
//  Sports App
//
//  Created by Zienab on 18/02/2023.
//

import Foundation
class LeagueItem : Decodable{
    var league_key:Int?
    var league_name:String?
}

class LeagueSport : Decodable {
    var success:Int?
    var result:[LeagueItem]
}
