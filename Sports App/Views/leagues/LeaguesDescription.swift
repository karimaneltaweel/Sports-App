//
//  LeaguesDescription.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit

class LeaguesDescription: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    @IBOutlet weak var upComming: UICollectionView!
    @IBOutlet weak var latestResult: UICollectionView!
    @IBOutlet weak var teams: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upComming){
            
            return 20
            
        }
        if (collectionView == latestResult){

            return 20
            
        }
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == upComming){
            
            return CGSize(width:self.view.frame.width, height: self.view.frame.height*0.17)
            
        }
        if (collectionView == latestResult){

            return CGSize(width: self.view.frame.width*0.95 , height: self.view.frame.height * 0.17)
            
        }
        
        return CGSize(width: self.view.frame.width * 0.35, height: self.view.frame.height * 0.17)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == upComming){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcoming", for: indexPath) as! UpcomingItem
            cell.team1Label.text = "team1"
            cell.team2Label.text = "team2"
            return cell
            
        }
        if (collectionView == latestResult){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestresult", for: indexPath) as! LatestResultItem
            cell.team2Label.text = "real"
            cell.team1Label.text = "ahly"
            cell.scoreLabel.text = "2-1"
            
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsItem
        
        return cell
    }
    
    


}
