//
//  MoviewTableViewCell.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MoviewTableViewCell: UITableViewCell {
    var imgIV = UIImageView()
    var titleLabel = UILabel()
    let scoreLabel = UILabel()
    let dateLabel = UILabel()
    let languageLabel = UILabel()
    
    let popularityLabel = UILabel()
    let adultIV = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        addSubviews(imgIV, titleLabel,dateLabel,scoreLabel, languageLabel, adultIV, popularityLabel)
        
        imgIV.clipsToBounds = true
        imgIV.contentMode = .ScaleAspectFill
        constrain(imgIV) { imgIV in
            imgIV.left == imgIV.superview!.left + 18
            imgIV.top == imgIV.superview!.top + 10
            imgIV.bottom == imgIV.superview!.bottom - 10
            imgIV.width == 150
        }
        
        var fontSize : CGFloat = 15
        if UIScreen.mainScreen().bounds.size.width < 375 {
            fontSize = 14
        }
        titleLabel.numberOfLines = 0
        titleLabel.withFontHeleticaMedium(fontSize).withTextColor(UIColor.defaultBlack())
        titleLabel.textAlignment = .Left
        
        scoreLabel.withFontHeletica(fontSize).withTextColor(UIColor.defaultBlack())
        
        dateLabel.numberOfLines = 1
        dateLabel.withFontHeletica(fontSize).withTextColor(UIColor.defaultBlack())
        dateLabel.textAlignment = .Left
        
        languageLabel.numberOfLines = 0
        languageLabel.withFontHeletica(fontSize).withTextColor(UIColor.defaultBlack())
        
        popularityLabel.numberOfLines = 1
        popularityLabel.withFontHeletica(fontSize).withTextColor(UIColor.defaultBlack())
        
        adultIV.image = UIImage(named: "RestrictIcon")
        let borderV = UIView()
        borderV.backgroundColor = UIColor(fromHexString: "cecece")
        addSubview(borderV)
        
        constrain(titleLabel, imgIV, scoreLabel, popularityLabel, dateLabel) { titleLabel, imgIV, scoreLabel, popularityLabel, dateLabel in
            titleLabel.left == imgIV.right + 10
            titleLabel.right == titleLabel.superview!.right - 20
            titleLabel.top == titleLabel.superview!.top + 15
            
            scoreLabel.left == titleLabel.left
            scoreLabel.top == titleLabel.bottom + 8

            popularityLabel.left == titleLabel.left
            popularityLabel.right == popularityLabel.superview!.right - 20
            popularityLabel.top == scoreLabel.bottom + 8
          
            dateLabel.left == titleLabel.left
            dateLabel.right == dateLabel.superview!.right - 20
            dateLabel.top == popularityLabel.bottom + 8
        }
        
        constrain(dateLabel, languageLabel, adultIV, borderV) {dateLabel, languageLabel, adultIV, borderV in
            languageLabel.left == dateLabel.left
            languageLabel.right == languageLabel.superview!.right - 20
            languageLabel.top == dateLabel.bottom + 8
            
            adultIV.left == languageLabel.left
            adultIV.top == languageLabel.bottom + 5
            adultIV.width == 42
            adultIV.height == 42
            
            borderV.left == borderV.superview!.left + 20
            borderV.right == borderV.superview!.right - 20
            borderV.height == 0.5
            borderV.bottom == borderV.superview!.bottom
        }
        
       
        //  containView.addSubview(borderV)
    }
    
    func setInfo(urlStr : String?, title : String?, score : String?, year : String?, language : String?){
        imgIV.sd_setImageWithURLStr(urlStr)
        scoreLabel.text = score
        titleLabel.text = title
        dateLabel.text = year
        languageLabel.text = language
    }
    
    func showRestricted(show : Bool){
        adultIV.hidden = !show
    }
    
    func popularity(str : String?){
        popularityLabel.text = str
    }
    
    func clearInfo(){
        imgIV.image = UIImage(named: "PosterPlaceHolder")
        scoreLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        languageLabel.text = nil
        popularityLabel.text = nil
        adultIV.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
