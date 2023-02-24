//
//  OnBoardingCell.swift
//  Sports App
//
//  Created by kariman eltawel on 24/02/2023.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    @IBOutlet weak var imageSlide: UIImageView!
    
    @IBOutlet weak var titleSlide: UILabel!
    
    @IBOutlet weak var descriptionSlide: UILabel!
    
    func setup(slide:OnboardingSlider)
    {
        imageSlide.image = slide.image
        titleSlide.text = slide.title
        descriptionSlide.text = slide.description
        
    }
}
