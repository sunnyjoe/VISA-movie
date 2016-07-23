//
//  MainViewController.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let one = GenreListNetTask()
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            do {
                let data = responseObject as! NSDictionary
               // let jsonObject = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("json: \(data)")
                // use jsonObject here
            } catch {
                print("json error")
            }
            
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)

    }

}
