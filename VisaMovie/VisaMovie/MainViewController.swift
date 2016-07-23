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
    let genreTable = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     //   title = "Moview Explore"
        
        let one = SearchMovieNetTask()
        one.yearRelased = 2000
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
