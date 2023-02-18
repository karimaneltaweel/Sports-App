//
//  Sports.swift
//  Sports App
//
//  Created by Omar on 17/02/2023.
//

import Foundation
import Alamofire
class FootballItem:Decodable{
    var league_key:Int?
    var league_name:String?
    var country_key:Int?
    var country_name:String?
    var league_logo:String?
    var country_logo:String?
}

class Football:Decodable{
    var success:Int?
    var result:[FootballItem]
    static func fetchFootballLeages(complition : @escaping (Football?)-> Void){
        
        AF.request("https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34")
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(Football.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
}
