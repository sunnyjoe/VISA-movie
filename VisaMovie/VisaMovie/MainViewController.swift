//
//  MainViewController.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var movieGenreList = [MovieGenre]()
    
    let genreTable = ListView(frame : CGRectMake(0, 0, 150, 250))
    let genreBtn = UIButton()
    let yearTF = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let one = GenreListNetTask()
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
             print(responseObject)
            if let data = responseObject as? NSDictionary {
                self.movieGenreList = GenreListNetTask.parseResultToGenreList(data)
                self.resetGenreList()
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
        
        let topView = UIView(frame : CGRectMake(0, 0, view.frame.size.width, 64))
        topView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(topView)
        buildTopView(topView)
    }
    
    func searchBtnDidTapped(){
        let one = SearchMovieNetTask()
        if let tmp = yearTF.text{
            one.yearRelased = Int(tmp)
        }
        one.genre = 18
        
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            print(responseObject)
            //            if let data = responseObject as? NSDictionary {
            //                self.movieGenreList = GenreListNetTask.parseResultToGenreList(data)
            //            }
            
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
    }

}


extension MainViewController{
    func buildTopView(containView : UIView){
        genreBtn.frame = CGRectMake(10, 20, 150, 44)
        genreBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        genreBtn.setTitle("Select a genre", forState: .Normal)
        containView.addSubview(genreBtn)
        genreBtn.addTarget(self, action: #selector(genreBtnDidTapped), forControlEvents: .TouchUpInside)
        genreBtn.layer.borderColor = UIColor.blackColor().CGColor
        genreBtn.layer.borderWidth = 0.5
        
        yearTF.frame = CGRectMake(180, 25, 100, 30)
        yearTF.placeholder = "Year(2016)"
        yearTF.layer.borderColor = UIColor.blackColor().CGColor
        yearTF.layer.borderWidth = 0.5
        containView.addSubview(yearTF)
        
        let searchBtn = UIButton(frame : CGRectMake(290, 20, 60, 44))
        searchBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        searchBtn.setTitle("Search", forState: .Normal)
        containView.addSubview(searchBtn)
        searchBtn.addTarget(self, action: #selector(searchBtnDidTapped), forControlEvents: .TouchUpInside)
    }
    
    func genreBtnDidTapped() {
        
    }
    
    func resetGenreList(){
        
    }
}
