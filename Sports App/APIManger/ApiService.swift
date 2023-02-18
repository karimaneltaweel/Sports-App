//
//  ApiService.swift
//  Sports App
//
//  Created by Zienab on 18/02/2023.
//

import Foundation
import Alamofire


class ApiService {
    static func fetchLeagues(sport_type:String ,complition : @escaping (LeagueSport?)-> Void){
        // ------Leagues API
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?met=Leagues&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        
        AF.request(API_URL)
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(LeagueSport.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
    
    
    static func fetchUpComming(sport_type:String ,complition : @escaping (UpComingEvents?)-> Void){
        // ------UpComming API
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?met=Fixtures&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34&from=2023-02-17&to=2023-02-17"
        
        AF.request(API_URL)
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

