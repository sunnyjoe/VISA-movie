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
    let ytPlayer = YTPlayerView()
    
    let bannerView = UIView()
    init(movieInfo : MovieInfo) {
        super.init(nibName: nil, bundle: nil)
        self.movieInfo = movieInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor.whiteColor()
        title = movieInfo.title
        
      //  updateMovieInfoView()
        
        let one = MovieDetailNetTask()
        one.movieId = movieInfo.id
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                self.movieInfo = MovieDetailNetTask.parseResultToMovieInfo(data)
               // self.updateMovieInfoView()
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
        }
        NetWorkHandler.sharedInstance.sendNetTask(one)
        
        //        ytPlayer.frame = CGRectMake(0, 300, view.frame.size.width, 300)
        //        view.addSubview(ytPlayer)
        //
        //
        //        let one = MovieVideosNetTask()
        //        one.movieId = movieInfo.id
        //        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
        //            if let data = responseObject as? NSDictionary {
        //                let video = MovieVideosNetTask.parseResultToMovieVideoList(data)
        //                if video.count > 0{
        //                    self.ytPlayer.loadWithVideoId(video[0].key)
        //                }
        //            }
        //        }
        //        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
        //            print("MovieTrailerNetTask failed")
        //            print(error.description)
        //        }
        //        NetWorkHandler.sharedInstance.sendNetTask(one)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieInfoViewController {
    func updateMovieInfoView(containView : UIView){
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
