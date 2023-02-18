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
    //tennis
    var event_first_player : String?
    var event_second_player : String?
    var event_first_player_logo : String?
    var event_second_player_logo : String?
}

class UpComingEvents: Decodable{
    
    var success: Int?
    var result: [Event]
    
    static func fetchCricketLeages(sport:String ,complition : @escaping (UpComingEvents?)-> Void){
        
        AF.request("https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34&from=2023-02-17&to=2023-02-17")
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(UpComingEvents.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
}
