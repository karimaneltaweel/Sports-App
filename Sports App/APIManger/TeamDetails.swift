//
//  TeamDetails.swift
//  Sports App
//
//  Created by kariman eltawel on 19/02/2023.
//

import Foundation
class Player:Decodable{
    var player_name: String?
    var player_number: String?
    var player_age: String?
    var player_image: String?
    var player_type: String?
}

class Coach:Decodable{
    var coach_name: String?
}

class Team: Decodable{
    var team_name: String?
    var team_logo: String?
    var players :[Player]
    var coaches :[Coach]
}

class TeamDetails: Decodable{
    var success: Int?
    var result: [Team]
}


//class TeamCK:Decodable{
//    var success:Int?
//    var result:[TeamResult]
//}
//class TeamResult:Decodable{
//    var team_name: String?
//    var team_logo: String?
//    var team_key: Int?
//}
