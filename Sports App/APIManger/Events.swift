//
//  UpcomingEvents.swift
//  Sports App
//
//  Created by Zienab on 17/02/2023.
//

import Foundation
import Alamofire
class Event: Decodable{
    var event_date : String?
    //basketball cricket
    var event_home_team: String?
    var event_away_team: String?
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    //football logoes
    var home_team_logo: String?
    var away_team_logo: String?
    
    // cricket date
    var event_date_start : String?
    var event_away_final_result : String?
    //tennis
    var event_first_player : String?
    var event_second_player : String?
    var event_first_player_logo : String?
    var event_second_player_logo : String?
    //key---for--f-b-c
    var home_team_key:Int?
    //key--for--t
    var first_player_key :Int?
}

class UpComingEvents: Decodable{
    
    var success: Int?
    var result: [Event]
}
