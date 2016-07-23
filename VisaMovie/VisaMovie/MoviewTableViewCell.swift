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
    var overviewLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews(imgIV, titleLabel,overviewLabel)
        
        imgIV.contentMode = .ScaleAspectFit
        constrain(imgIV) { imgIV in
            imgIV.left == imgIV.superview!.left + 23
            imgIV.top == imgIV.superview!.top + 10
            imgIV.bottom == imgIV.superview!.bottom - 10
            imgIV.width == 150
        }
        titleLabel.numberOfLines = 1
        titleLabel.withFontHeleticaMedium(15).withTextColor(UIColor.defaultBlack())
        titleLabel.textAlignment = .Left
        
        overviewLabel.numberOfLines = 0
        overviewLabel.withFontHeletica(15).withTextColor(UIColor.defaultBlack())
        overviewLabel.textAlignment = .Left
        
        constrain(titleLabel,imgIV, overviewLabel) { titleLabel, imgIV, overviewLabel in
            titleLabel.left == imgIV.right + 10
            titleLabel.right == titleLabel.superview!.right - 23
            
            overviewLabel.left == titleLabel.left
            overviewLabel.top == titleLabel.bottom + 3
            overviewLabel.bottom == overviewLabel.superview!.bottom - 10
        }
    }
    
    func setInfo(urlStr : String?, title : String?, overview : String?){
        imgIV.sd_setImageWithURLStr(urlStr)
        titleLabel.text = title
        overviewLabel.text = overview
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
