//
//  ApiService.swift
//  Sports App
//
//  Created by Zienab on 18/02/2023.
//

import Foundation
import Alamofire

protocol NetworkService
{
    static func fetchFromApi<T : Decodable>( team_key:Int  , sport_type:String ,complition : @escaping (T?)-> Void)
}


class ApiService : NetworkService{
    static func fetchFromApi<T>( team_key:Int , sport_type: String, complition: @escaping (T?) -> Void) where T : Decodable {
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?&met=Teams&teamId=\(team_key)&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        AF.request(API_URL).responseJSON { res in
            do
            {
                guard let responseData = res.data else {return}
                let res = try JSONDecoder().decode(T.self, from: responseData)
                complition(res)
                
            }catch let error {
                complition(nil)
                print(error.localizedDescription)
                
            }
        }
    }

    
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
    
    
    static func fetchUpComming(sport_type:String, legKey:Int ,complition : @escaping (UpComingEvents?)-> Void){
        // ------UpComming API -- Teams API
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-02-19&to=2023-02-20&leagueId=\(legKey)"
    
        
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
    
    
    static func fetchLatestRes(sport_type:String ,complition : @escaping (LatestRes?)-> Void){
        // ------ Latest result API -----------
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?met=Livescore&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        
        AF.request(API_URL)
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(LatestRes.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
    
    static func fetchTeamDetails(sport_type:String ,team_key:Int,complition : @escaping (TeamDetails?)-> Void){
        // ------ Team Details API -----------
        let API_URL = "https://apiv2.allsportsapi.com/\(sport_type)/?&met=Teams&teamId=\(team_key)&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        
        AF.request(API_URL)
            .responseJSON { res in
                do
                {
                    guard let responseData = res.data else {return}
                    let res = try JSONDecoder().decode(TeamDetails.self, from: responseData)
                    complition(res)
                    
                }catch let error {
                    complition(nil)
                    print(error.localizedDescription)
                    
                }
            }
    }
    
    }

