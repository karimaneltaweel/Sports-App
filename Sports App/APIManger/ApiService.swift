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
    static func fetchFromApi<T : Decodable>( API_URL:String ,complition : @escaping (T?, Dictionary<String , Any>)-> Void)
}


class ApiService : NetworkService{
    static func fetchFromApi<T>( API_URL: String, complition: @escaping (T? , Dictionary<String , Any>) -> Void) where T : Decodable {
        AF.request(API_URL).responseJSON { res in
            do
            {
                
                guard let responseData = res.data else {return}
                let result = try JSONDecoder().decode(T.self, from: responseData)
                guard let jsonResponse = try res.result.get() as?  [String : Any] else{ return}
                complition(result,jsonResponse)
                
            }catch let error {
                complition(nil , [:])
                print(error.localizedDescription)
                
            }
        }
    }
    }

