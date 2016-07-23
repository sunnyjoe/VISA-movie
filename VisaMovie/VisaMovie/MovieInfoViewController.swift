//
//  MovieInfoViewController.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    var movieInfo : MovieInfo!
    
    init(movieInfo : MovieInfo) {
        super.init(nibName: nil, bundle: nil)
        self.movieInfo = movieInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor.whiteColor()
        title = movieInfo.title
        
        let topView = UIView()
        view.addSubview(topView)
        constrain(topView) { topView in
            topView.left == topView.superview!.left
            topView.top == topView.superview!.top
            topView.right == topView.superview!.right
            topView.height == 270
        }
        buildTopView(topView)
        
        let one = MovieVideosNetTask()
        one.movieId = movieInfo.id
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
              print(data)
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
        }
        NetWorkHandler.sharedInstance.sendNetTask(one)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieInfoViewController {
    func buildTopView(containView : UIView){
        let imgIV = UIImageView()
        let titleLabel = UILabel()
        let overviewLabel = UILabel()
        
        containView.addSubviews(imgIV, titleLabel,overviewLabel)
        imgIV.sd_setImageWithURLStr(movieInfo.imageUrl)
        titleLabel.text = movieInfo.title
        overviewLabel.text = movieInfo.overview
        
        imgIV.clipsToBounds = true
        imgIV.contentMode = .ScaleAspectFill
        constrain(imgIV) { imgIV in
            imgIV.left == imgIV.superview!.left + 23
            imgIV.top == imgIV.superview!.top + 10
            imgIV.bottom == imgIV.superview!.bottom - 10
            imgIV.width == 200
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
            titleLabel.top == titleLabel.superview!.top + 10
            
            overviewLabel.left == titleLabel.left
            overviewLabel.right == overviewLabel.superview!.right - 23
            overviewLabel.top == overviewLabel.superview!.top + 30
            overviewLabel.bottom == overviewLabel.superview!.bottom - 10
        }
    }
    
    func buildTrailerView(){
        
    }
}
