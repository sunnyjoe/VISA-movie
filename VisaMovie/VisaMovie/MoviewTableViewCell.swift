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
    let languageLabel = UILabel()
    let genreLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        addSubviews(imgIV, titleLabel,languageLabel,scoreLabel)
        
        imgIV.contentMode = .ScaleAspectFit
        constrain(imgIV) { imgIV in
            imgIV.left == imgIV.superview!.left + 18
            imgIV.top == imgIV.superview!.top + 10
            imgIV.bottom == imgIV.superview!.bottom - 10
            imgIV.width == 150
        }
        titleLabel.numberOfLines = 0
        titleLabel.withFontHeleticaMedium(15).withTextColor(UIColor.defaultBlack())
        titleLabel.textAlignment = .Left
        
        scoreLabel.withFontHeletica(15).withTextColor(UIColor.defaultBlack())
        
        languageLabel.numberOfLines = 0
        languageLabel.withFontHeletica(15).withTextColor(UIColor.defaultBlack())
        languageLabel.textAlignment = .Left
        
        constrain(titleLabel,imgIV, scoreLabel, languageLabel) { titleLabel, imgIV, scoreLabel, languageLabel in
            titleLabel.left == imgIV.right + 8
            titleLabel.right == titleLabel.superview!.right - 23
            titleLabel.top == titleLabel.superview!.top + 10
            
            scoreLabel.left == titleLabel.left
            scoreLabel.top == titleLabel.bottom + 5
//
            languageLabel.left == titleLabel.left
            languageLabel.right == languageLabel.superview!.right - 23
            languageLabel.top == scoreLabel.bottom + 5
         //   overviewLabel.bottom == overviewLabel.superview!.bottom - 10
        }
    }
    
    func setInfo(urlStr : String?, title : String?, score : String?, genre : String?){
        imgIV.image = UIImage(named: "PosterPlaceHolder")
        
        imgIV.sd_setImageWithURLStr(urlStr)
        scoreLabel.text = score
        titleLabel.text = title
        languageLabel.text = genre
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
