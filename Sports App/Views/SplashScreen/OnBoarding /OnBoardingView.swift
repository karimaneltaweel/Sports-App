//
//  OnBoardingView.swift
//  Sports App
//
//  Created by kariman eltawel on 24/02/2023.
//

import UIKit

class OnBoardingView: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //array
    var arraySlider :[OnboardingSlider] = []
     
    @IBOutlet weak var SliderCollection: UICollectionView!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    @IBOutlet weak var pageSlider: UIPageControl!
    
    var currentpagee = 0 {
        didSet{
            
            pageSlider.currentPage = currentpagee

            if currentpagee == arraySlider.count - 1{
                
                buttonOutlet.setTitle("Get Started", for: .normal)
            }
            else{
                buttonOutlet.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arraySlider = [OnboardingSlider(title: "Football", description: "Football , also called association football or soccer,Is game involving two teams of 11 player who try to maneuver the ball into the other team’s goals without using their hands or arms", image: UIImage(named: "spfoot")!),OnboardingSlider(title:"Cricket", description: "Cricket ,played with a bat and ball and involves two competing sides (teams) of 11 players.", image:UIImage(named:"spcri")! ),OnboardingSlider(title: "Basketball", description: "Basketball ,a game in which two teams of five players each try to score goals by throwing a large ball through a circular net fixed to a metal ring at each end of the court.", image:UIImage(named:"spbas")! )]

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySlider.count
    }
    
    
    @IBAction func sliderButton(_ sender: Any) {
        
        if currentpagee == arraySlider.count - 1 {

            let sportsView = self.storyboard?.instantiateViewController(withIdentifier: "SportsTabBar") as!SportsTabBar
            self.navigationController?.pushViewController(sportsView, animated: true)

        }else{
            
            currentpagee += 1

            
            let indexpath = IndexPath(item: currentpagee, section:0)
            SliderCollection.scrollToItem(at: indexpath, at:.centeredHorizontally, animated: true)


        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "boardingItem", for: indexPath) as! OnBoardingCell

        cell.setup(slide: arraySlider[indexPath.row])
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let width = scrollView.frame.width
        currentpagee = Int(scrollView.contentOffset.x / width)
        pageSlider.currentPage = currentpagee
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    

}
