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
    let overviewDescLabel = UILabel()
    let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(titleLabel, scoreLabel, languageLabel, genreLabel, contryLabel, companyLabel, overviewLabel, overviewDescLabel)
        
        titleLabel.numberOfLines = 0
        titleLabel.withTextColor(UIColor.defaultBlack()).withFontHeleticaMedium(17).textCentered()
        scoreLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        languageLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        genreLabel.numberOfLines = 0
        genreLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        contryLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        companyLabel.numberOfLines = 0
        companyLabel.withTextColor(UIColor.defaultBlack()).withFontHeletica(15)
        
        overviewDescLabel.withTextColor(UIColor.defaultBlack()).withFontHeleticaMedium(16).withText("Overview:")
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
            
            contryLabel.top == languageLabel.bottom + 8
            contryLabel.left == contryLabel.superview!.left + 23
            contryLabel.right == contryLabel.superview!.right - 23
        }
        
        constrain(contryLabel, overviewDescLabel) {contryLabel, overviewDescLabel in
            overviewDescLabel.top == contryLabel.bottom + 10
            overviewDescLabel.left == overviewDescLabel.superview!.left + 23
        }
        
        constrain(overviewDescLabel, overviewLabel) {overviewDescLabel, overviewLabel in
            overviewLabel.top == overviewDescLabel.bottom + 5
            overviewLabel.left == overviewLabel.superview!.left + 23
            overviewLabel.right == overviewLabel.superview!.right - 23
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func getViewHeight() -> CGFloat{
        titleLabel.setNeedsLayout()
        scoreLabel.setNeedsLayout()
        languageLabel.setNeedsLayout()
        genreLabel.setNeedsLayout()
        contryLabel.setNeedsLayout()
        companyLabel.setNeedsLayout()
        overviewLabel.setNeedsLayout()
        
        titleLabel.layoutIfNeeded()
        scoreLabel.layoutIfNeeded()
        languageLabel.layoutIfNeeded()
        genreLabel.layoutIfNeeded()
        contryLabel.layoutIfNeeded()
        companyLabel.layoutIfNeeded()
        overviewLabel.layoutIfNeeded()
        
        setNeedsLayout()
        layoutIfNeeded()
        return CGRectGetMaxY(overviewLabel.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
