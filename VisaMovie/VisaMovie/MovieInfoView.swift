//
//  MovieInfoView.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieInfoView: UIView {
    let titleLabel = UILabel()
    let scoreLabel = UILabel()
    let languageLabel = UILabel()
    let genreLabel = UILabel()
    let contryLabel = UILabel()
    let companyLabel = UILabel()
    let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(titleLabel, scoreLabel, languageLabel, genreLabel, contryLabel, companyLabel, overviewLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.withTextColor(UIColor.defaultBlack()).withFontHeleticaMedium(17).textCentered()
        scoreLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        languageLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        genreLabel.numberOfLines = 0
        genreLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        contryLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        companyLabel.numberOfLines = 0
        companyLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        overviewLabel.numberOfLines = 0
        overviewLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        constrain(titleLabel, scoreLabel, genreLabel, languageLabel, contryLabel) { titleLabel, scoreLabel, genreLabel, languageLabel, contryLabel in
            titleLabel.centerX == titleLabel.superview!.centerX
            titleLabel.top == titleLabel.superview!.top
            titleLabel.left == titleLabel.superview!.left + 23
            titleLabel.right == titleLabel.superview!.right - 23
            
            scoreLabel.left == scoreLabel.superview!.left + 23
            scoreLabel.top == titleLabel.bottom + 5
            
            genreLabel.top == scoreLabel.bottom + 5
            genreLabel.left == genreLabel.superview!.left + 23
            genreLabel.right == genreLabel.superview!.right - 23
            
            languageLabel.top == genreLabel.bottom + 5
            languageLabel.left == languageLabel.superview!.left + 23
            
            contryLabel.top == languageLabel.bottom + 5
            contryLabel.left == contryLabel.superview!.left + 23
            contryLabel.right == contryLabel.superview!.right - 23
        }
        
        constrain(contryLabel, companyLabel, overviewLabel) {contryLabel, companyLabel, overviewLabel in
            companyLabel.top == contryLabel.bottom + 5
            companyLabel.left == companyLabel.superview!.left + 23
            companyLabel.right == companyLabel.superview!.right - 23
            
            overviewLabel.top == companyLabel.bottom + 5
            overviewLabel.left == overviewLabel.superview!.left + 23
            overviewLabel.right == overviewLabel.superview!.right - 23
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
