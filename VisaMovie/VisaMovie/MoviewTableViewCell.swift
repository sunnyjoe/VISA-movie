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
    
    let adultIV = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        addSubviews(imgIV, titleLabel,dateLabel,scoreLabel, languageLabel, adultIV)
        
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
        
        adultIV.image = UIImage(named: "RestrictIcon")
        let borderV = UIView()
        borderV.backgroundColor = UIColor(fromHexString: "cecece")
        addSubview(borderV)
        
        constrain(titleLabel,imgIV, scoreLabel, dateLabel, languageLabel) { titleLabel, imgIV, scoreLabel, dateLabel, language in
            titleLabel.left == imgIV.right + 10
            titleLabel.right == titleLabel.superview!.right - 20
            titleLabel.top == titleLabel.superview!.top + 15
            
            scoreLabel.left == titleLabel.left
            scoreLabel.top == titleLabel.bottom + 8

            dateLabel.left == titleLabel.left
            dateLabel.right == dateLabel.superview!.right - 20
            dateLabel.top == scoreLabel.bottom + 8
          
            language.left == titleLabel.left
            language.right == language.superview!.right - 20
            language.top == dateLabel.bottom + 8
        }
        
        constrain(languageLabel, adultIV, borderV) {languageLabel, adultIV, borderV in
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
        imgIV.image = UIImage(named: "PosterPlaceHolder")
        
        imgIV.sd_setImageWithURLStr(urlStr)
        scoreLabel.text = score
        titleLabel.text = title
        dateLabel.text = year
        languageLabel.text = language
    }
    
    func showRestricted(show : Bool){
        adultIV.hidden = !show
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
