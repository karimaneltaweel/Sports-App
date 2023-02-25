//
//  CoreDataManager.swift
//  Sports App
//
//  Created by Omar on 20/02/2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager
{
   static var context : NSManagedObjectContext?
   static var appDelegate : AppDelegate?
    
    
    static func saveToCoreData(team_name : String , team_logo : String , team_key : Int)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        guard let myContext = context else{return}
        
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: myContext)
        
        guard let myEntity = entity else{return}
        
        do{
            
            
            let favorite_team = NSManagedObject(entity: myEntity, insertInto: myContext)
            
            
            favorite_team.setValue(team_name, forKey: "teamName")
            favorite_team.setValue(team_logo, forKey: "teamLogo")
            favorite_team.setValue(team_key, forKey: "teamKey")

            print("Saved Successfully")
            
            
            try myContext.save()
            
        }catch let error{
            
            print(error.localizedDescription)
        }
    }
    
    
    
//    static func saveStateOfButton(isFavorite : Bool)
//    {
//        appDelegate = UIApplication.shared.delegate as? AppDelegate
//
//        context = appDelegate?.persistentContainer.viewContext
//
//        guard let myContext = context else{return}
//
//        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: myContext)
//
//        guard let myEntity = entity else{return}
//
//        do{
//
//
//            let favorite_team = NSManagedObject(entity: myEntity, insertInto: myContext)
//
//
//            favorite_team.setValue(isFavorite, forKey: "isFavorite")
//
//            print("State Saved Successfully")
//
//
//            try myContext.save()
//
//        }catch let error{
//
//            print(error.localizedDescription)
//        }
//    }
    
    
    
    static func deleteFromCoreData(team_name :String)
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        do{
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let predictt = NSPredicate(format: "teamName == %@",team_name)
            fetch.predicate = predictt
            
            let favteams = try context?.fetch(fetch)
            
            guard let item = favteams else {return}
            guard let itemFirst = item.first else {return}
            
             context?.delete(itemFirst)
            
            try context?.save()
            
            print("Deleted Succussfully")
            
        }catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    
    
    static func fetchFromCoreData() ->[FavoriteTeam]
    {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        context = appDelegate?.persistentContainer.viewContext
        
        
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        var arrayOfFavTeam : [FavoriteTeam] = []
        
        do{
            
            
            
            let favteams = try context?.fetch(fetch)
            
            guard let myteam = favteams else{return []}
            
            for item in myteam
            {
                var team_name = item.value(forKey: "teamName")
                var team_logo = item.value(forKey: "teamLogo")
                
                var team = FavoriteTeam(team_name: team_name as? String ,team_logo: team_logo as? String)
                
                arrayOfFavTeam.append(team)
            }
            
        }catch let error
        {
            print(error.localizedDescription)
        }
        return arrayOfFavTeam
    }
}
