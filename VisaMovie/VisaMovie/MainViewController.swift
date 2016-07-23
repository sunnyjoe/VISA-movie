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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let one = GenreListNetTask()
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                self.movieGenreList = GenreListNetTask.parseResultToGenreList(data)
            }
            
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)

    }

}
