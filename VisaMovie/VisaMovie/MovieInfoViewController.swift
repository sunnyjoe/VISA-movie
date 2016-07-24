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
    
    let scrollView = UIScrollView()
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
        
        scrollView.frame = view.bounds
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 23, 0)
        view.addSubview(scrollView)
        
        bannerView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height * 0.617)
        textInfoView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame) + 8, view.frame.size.width, 200)
        let borderV = UIView(frame : CGRectMake(0, CGRectGetMaxY(bannerView.frame), view.frame.size.width, 0.5))
        borderV.backgroundColor = UIColor(fromHexString: "cecece")
        
        scrollView.addSubview(bannerView)
        scrollView.addSubview(textInfoView)
        scrollView.addSubview(borderV)
        
        ytPlayer.layer.borderColor = UIColor.defaultBlack().CGColor
        ytPlayer.layer.borderWidth = 0.5
        view.addSubview(ytPlayer)
        ytPlayer.frame = CGRectMake(view.frame.size.width - 200, view.frame.size.height - 140, 200, 140)
        ytPlayer.hidden = true
        resetUI()
        
        getMovieDetailInfo()
        getMovieVideoInfo()
        
        view.addSubview(backButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func getMovieVideoInfo(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let vNetTask = MovieVideosNetTask()
        vNetTask.movieId = movieInfo.id
        vNetTask.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                let video = MovieVideosNetTask.parseResultToMovieVideoList(data)
                if video.count > 0{
                    self.ytPlayer.loadWithVideoId(video[0].key)
                    self.ytPlayer.hidden = false
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 23 + 140, 0)
                }
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        vNetTask.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            MBProgressHUD.showHUDAddedTo(self.view, text: "Sorry, please try later", duration: 1)
        }
        NetWorkHandler.sharedInstance.sendNetTask(vNetTask)
    }
    
    func getMovieDetailInfo(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let dNetTask = MovieDetailNetTask()
        dNetTask.movieId = movieInfo.id
        dNetTask.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                self.movieInfo = MovieDetailNetTask.parseResultToMovieInfo(data)
                self.resetUI()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        dNetTask.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("MovieTrailerNetTask failed")
            print(error.description)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            MBProgressHUD.showHUDAddedTo(self.view, text: "Sorry, please try later", duration: 1)
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
        if banners.count == 0 {
            banners.append("http://www.bingeu.com/posters/placeholder.png")
        }
        bannerView.setScrollImages(banners)
        
        textInfoView.titleLabel.text = movieInfo.title
        if let rate = movieInfo.rating {
            textInfoView.scoreLabel.text = "Score: \(rate)"
        }
        
        if let lan = movieInfo.language{
            textInfoView.languageLabel.text = "Language: " + lan
        }
        
        let completion = {(name : String?) -> Void in
            if name != nil {
                self.textInfoView.genreLabel.text = "Genres: " + name!
            }
        }
        DataContainer.sharedInstace.getGenreNamesFromId(self.movieInfo.genreIds, completion: completion)
        
        if let ct = movieInfo.country{
            textInfoView.contryLabel.text = "Country: " + ct
        }
        if let cN = movieInfo.companyName{
            textInfoView.companyLabel.text = "Company: " + cN
        }
        let tmp = movieInfo.overview
        if tmp != nil && tmp != " "{
            textInfoView.overviewLabel.text = tmp
        }else{
            textInfoView.overviewLabel.text = "Not Available."
        }
        
        let height = textInfoView.getViewHeight()
        textInfoView.frame = CGRectMake(0, textInfoView.frame.origin.y, scrollView.frame.size.width, height)
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, CGRectGetMaxY(textInfoView.frame))
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
