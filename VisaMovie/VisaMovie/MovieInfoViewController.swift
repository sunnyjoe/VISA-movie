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
    
    let bannerView = ScrollableBannerView()
    let textInfoView = MovieInfoView()
    
    init(movieInfo : MovieInfo) {
        super.init(nibName: nil, bundle: nil)
        self.movieInfo = movieInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .None
        
        view.backgroundColor = UIColor.whiteColor()
        
        let backButton = UIButton(frame: CGRectMake(18, 24, 35, 35))
        backButton.setImage(UIImage(named: "BackIconNormal"), forState: .Normal)
        backButton.addTarget(self, action: #selector(backButtonDidClicked), forControlEvents: .TouchUpInside)
        
        let scrollView = UIScrollView(frame : view.bounds)
        view.addSubview(scrollView)
        
        scrollView.addSubview(bannerView)
        bannerView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.617)
        
        textInfoView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame) + 8, view.frame.size.width, 200)
        scrollView.addSubview(textInfoView)
        
        ytPlayer.frame = CGRectMake(0, 300, view.frame.size.width, 300)
        // view.addSubview(ytPlayer)
        resetUI()
        
        getMovieDetailInfo()
        getMovieVideoInfo()
        
        view.addSubview(backButton)
    }
    
    func getMovieVideoInfo(){
        let vNetTask = MovieVideosNetTask()
        vNetTask.movieId = movieInfo.id
        vNetTask.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                let video = MovieVideosNetTask.parseResultToMovieVideoList(data)
                if video.count > 0{
                    self.ytPlayer.loadWithVideoId(video[0].key)
                }
            }
        }
        vNetTask.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
        }
        NetWorkHandler.sharedInstance.sendNetTask(vNetTask)
    }
    
    func getMovieDetailInfo(){
        let dNetTask = MovieDetailNetTask()
        dNetTask.movieId = movieInfo.id
        dNetTask.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                self.movieInfo = MovieDetailNetTask.parseResultToMovieInfo(data)
                self.resetUI()
            }
        }
        dNetTask.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
        }
        NetWorkHandler.sharedInstance.sendNetTask(dNetTask)
    }
    
    func resetUI(){
        var banners = [String]()
        if let tmp = movieInfo.imageUrl{
            banners.append(tmp)
        }
        if let tmp = movieInfo.backdropUrl{
            banners.append(tmp)
        }
        bannerView.setScrollImages(banners)
        
        textInfoView.titleLabel.text = movieInfo.title
        if let rate = movieInfo.rating {
            textInfoView.scoreLabel.text = "Score: \(rate)"
        }
        
        if let lan = movieInfo.language{
            textInfoView.languageLabel.text = "Language: " + lan
        }
        if movieInfo.genreIds != nil {
            let completion = {(list : [MovieGenre]) -> Void in
                var combine = ""
                for one in list {
                    if self.movieInfo.genreIds!.contains(one.id) {
                        combine += " " + one.name
                    }
                }
                self.textInfoView.genreLabel.text = "Genres: " + combine
            }
            DataContainer.sharedInstace.getGenreList(completion)
        }
        if let ct = movieInfo.country{
            textInfoView.contryLabel.text = "Country: " + ct
        }
        if let cN = movieInfo.companyName{
            textInfoView.companyLabel.text = "Company: " + cN
        }
        textInfoView.overviewLabel.text = movieInfo.overview
    }
    
    func backButtonDidClicked(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func buildTrailerView(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
