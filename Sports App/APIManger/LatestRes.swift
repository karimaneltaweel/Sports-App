//
//  LatestRes.swift
//  Sports App
//
//  Created by Zienab on 18/02/2023.
//

import Foundation


class EventRes: Decodable{
    var event_home_team: String?
    var event_away_team: String?
    var event_final_result: String?
    
    //tennis
    var event_first_player : String?
    var event_second_player : String?
    
    
}

class LatestRes: Decodable{
    var success: Int?
    var result: [EventRes]
}
