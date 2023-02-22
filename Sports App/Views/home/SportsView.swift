//
//  SportsView.swift
//  Sports App
//
//  Created by kariman eltawel on 15/02/2023.
//

import UIKit
import Reachability
class SportsView: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    let sportsNames = ["Football","Basketball","Cricket","Tennis"]
    let Sportsimage = ["fimg","bimg","cimg","timg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
    

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Sportsimage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ItemsSports
        cell.sportimg.image = UIImage(named: Sportsimage[indexPath.row])
        cell.sportlabel.text = sportsNames[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.45, height: self.view.frame.height * 0.37)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 5, bottom: 1, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reachability = try! Reachability()
        switch reachability.connection {
          case .wifi:
              print("Reachable via WiFi")
            var leaguesTableView = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTableView") as! LeaguesTableView
            leaguesTableView.sport = sportsNames[indexPath.row]
            
            leaguesTableView.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(leaguesTableView, animated: true)
            
          case .cellular:
              print("Reachable via Cellular")
          case .unavailable:
            print("Network not reachable")
            showAlert()
        case .none:
            print("nothing!")
        }
       
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Worning", message: "You are currently offline, check your connection!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }

}
