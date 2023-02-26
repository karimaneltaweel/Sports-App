//
//  LeaguesDescription.swift
//  Sports App
//
//  Created by kariman eltawel on 16/02/2023.
//

import UIKit
import Kingfisher
class LeaguesDescription: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  
    @IBOutlet weak var TeamsLabelGui: UILabel!
    
    @IBOutlet weak var latest_resultlabel: UILabel!
    
    @IBOutlet weak var upcoming_label: UILabel!
    
    var events :UpComingEvents?
    var latestEvents: LatestRes?
    var sportType :String?
    var legKey:Int?
    
    @IBOutlet weak var upComming: UICollectionView!
    @IBOutlet weak var latestResult: UICollectionView!
    @IBOutlet weak var teams: UICollectionView!
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        print(legKey)
        super.viewDidLoad()
    
        TeamsLabelGui.layer.cornerRadius = 15
        TeamsLabelGui.clipsToBounds = true
        latest_resultlabel.layer.cornerRadius = 15
        latest_resultlabel.clipsToBounds = true
        upcoming_label.layer.cornerRadius = 15
        upcoming_label.clipsToBounds = true
        
                    let fadeView:UIView = UIView()
                    fadeView.frame = self.view.frame
                    fadeView.backgroundColor = UIColor.white
                    fadeView.alpha = 0.4

                    self.view.addSubview(fadeView)

                    self.view.addSubview(activityView)
                    activityView.hidesWhenStopped = true
                    activityView.center = self.view.center
                    activityView.startAnimating()
        
        
       changeSportTypeName()
        
        if sportType == "tennis"
        {
            TeamsLabelGui.text = "Players"
        }
        else{
            TeamsLabelGui.text = "Teams"
        }
        
        
            
        
        let API_URL_UPCOMMING = "https://apiv2.allsportsapi.com/\(sportType ?? "")/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-02-19&to=2023-02-20&leagueId=\(legKey ?? 0)"
        
        let API_URL_LATESTRES = "https://apiv2.allsportsapi.com/\(sportType ?? "")/?met=Livescore&APIkey=a10943e74d5f6b5225e523a43ddd99c7e3b3678d96a2091c93189206a81c6a34"
        
        ApiService.fetchFromApi(API_URL: API_URL_UPCOMMING) {  (data , dictionary) in
            self.events = data
            let flag = dictionary.contains { $0.key == "result" }
            DispatchQueue.main.async{
                self.latestResult.reloadData()
                print(flag)
                if flag
                {
                    print("upcomming appeared")
                }else{
                    self.showAlert()
                }
                UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                    self.upComming.reloadData()
                    self.teams.reloadData()
                    self.latestResult.reloadData()
                    self.upComming.alpha = 1
                    fadeView.removeFromSuperview()
                    self.activityView.stopAnimating()
                }, completion: nil)
            }
        }

    
        ApiService.fetchFromApi(API_URL: API_URL_LATESTRES) { data,dictionary in
            self.latestEvents = data
            DispatchQueue.main.async{
                
                self.latestResult.reloadData()

                
            }
        }
        
        
    }
    
    func changeSportTypeName(){
        switch(sportType){
        case "Football" :
            sportType = "football"
        case "Tennis" :
            sportType = "tennis"
        case "Basketball":
            sportType = "basketball"
        case "Cricket":
            sportType = "cricket"
        default:
           print("no type")
        }
    }
    

    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == upComming || collectionView == teams){
 
            return events?.result.count ?? 0
        }
        if sportType == "cricket"
        {
            return events?.result.count ?? 0
        }
            
            return latestEvents?.result.count ?? 0

            

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
            
            cell.configureCell(sportType: sportType ?? "", item: (events?.result[indexPath.row]) ?? Event())

            return cell
            
        }
        //------------- latest result collection --------------
         if (collectionView == latestResult){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestresult", for: indexPath) as! LatestResultItem
             cell.configureCell(sportType: sportType ?? "", item: (events?.result[indexPath.row]) ?? Event(), latestResItem: latestEvents?.result[indexPath.row] ?? EventRes())
            
            return cell
            
        }
        
        // -------------- Teams collection ------------
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsItem
        
        cell.configureCell(sportType: sportType ?? "", item: (events?.result[indexPath.row]) ?? Event())

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teams
        {
            if sportType == "tennis"{
                
                print("tennis")
            }
            else{
                
                let teamsDeatailsVC = self.storyboard?.instantiateViewController(withIdentifier: "TeamsDetailsView") as! TeamsDetailsView
                
                teamsDeatailsVC.team_key = events?.result[indexPath.row].home_team_key
                teamsDeatailsVC.sporttype = sportType
                
                self.navigationController?.pushViewController(teamsDeatailsVC, animated: true)}
        }
    }
    
    func showAlert(){
        // declare Alert
        let alert = UIAlertController(title: "⚠️", message: "missing data event", preferredStyle: .alert)
        
        
        
        //AddAction
        alert.addAction(UIAlertAction(title: "continue", style: .default , handler: {  action in
            print("continue clicked")
            
        }))
        
        alert.addAction(UIAlertAction(title: "go back", style: UIAlertAction.Style.cancel , handler: { action in
            print("Cancel clicked")
            self.navigationController?.popViewController(animated: true)
        }))
        

        //showAlert
        self.present(alert, animated: true) {
            print("alert done")
        }
    }


}
