//
//  Tennis.swift
//  Sports App
//
//  Created by Omar on 17/02/2023.
//

import Foundation
import Alamofire
class TennisOrBasketballItem:Decodable{
    var league_key:Int?
    var league_name:String?
    var country_key:Int?
    var country_name:String?
}

class TennisOrBasketball:Decodable{
    var success:Int?
    var result:[TennisOrBasketballItem]
    
    static func fetchSportsLeages(sport_type : String ,complition : @escaping (TennisOrBasketball?)-> Void){
        
        AF.request("https://apiv2.allsportsapi.com/\(sport_type)/?met=Leagues&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34")
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(TennisOrBasketball.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
}
