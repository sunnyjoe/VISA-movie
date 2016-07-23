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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        addSubviews(imgIV, titleLabel,dateLabel,scoreLabel)
        
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
        
        dateLabel.numberOfLines = 1
        dateLabel.withFontHeletica(15).withTextColor(UIColor.defaultBlack())
        dateLabel.textAlignment = .Left
        
        let borderV = UIView()
        borderV.backgroundColor = UIColor(fromHexString: "cecece")
        addSubview(borderV)
        
        constrain(titleLabel,imgIV, scoreLabel, dateLabel, borderV) { titleLabel, imgIV, scoreLabel, dateLabel, borderV in
            titleLabel.left == imgIV.right + 8
            titleLabel.right == titleLabel.superview!.right - 20
            titleLabel.top == titleLabel.superview!.top + 15
            
            scoreLabel.left == titleLabel.left
            scoreLabel.top == titleLabel.bottom + 8
//
            dateLabel.left == titleLabel.left
            dateLabel.right == dateLabel.superview!.right - 20
            dateLabel.top == scoreLabel.bottom + 8
         //   overviewLabel.bottom == overviewLabel.superview!.bottom - 10
            
            borderV.left == borderV.superview!.left + 20
            borderV.right == borderV.superview!.right - 20
            borderV.height == 0.5
            borderV.bottom == borderV.superview!.bottom
        }
        
       
        //  containView.addSubview(borderV)
    }
    
    func setInfo(urlStr : String?, title : String?, score : String?, year : String?){
        imgIV.image = UIImage(named: "PosterPlaceHolder")
        
        imgIV.sd_setImageWithURLStr(urlStr)
        scoreLabel.text = score
        titleLabel.text = title
        dateLabel.text = year
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
