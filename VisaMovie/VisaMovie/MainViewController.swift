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
        
        let one = SearchMovieNetTask()
        one.genre = 18
        one.year = 2000
        
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

}
