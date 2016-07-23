//
//  NetWorkWrapper.swift
//  FindFriends
//
//  Created by jiao qing on 19/7/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit

let OMDBBaseURL = "http://api.themoviedb.org/3/"
let OMDBAPIKey = "48b76c860a67d611af57a22d6126395a"

class NetWorkHandler: NSObject {
    static let sharedInstance = NetWorkHandler()
    
    let httpQueryStringManager : AFHTTPSessionManager = {
        let one = AFHTTPSessionManager(baseURL : NSURL(string: OMDBBaseURL))
        return one
    }()
    
    lazy var httpJSONManager : AFHTTPSessionManager = {
        let one = AFHTTPSessionManager(baseURL : NSURL(string: OMDBBaseURL))
        one.requestSerializer = AFJSONRequestSerializer()
        return one
    }()
    
    func sendNetTask(task : BaseNetTask){
        var httpManager = httpQueryStringManager
        let wholeURL = task.uri() + "?api_key=" + OMDBAPIKey
        
        if task.method() == HTTPTaskMethod.Post {
            httpManager = httpJSONManager
            
            let files = task.files()
            if files != nil && files!.count > 0{
                httpManager.POST(wholeURL, parameters: task.query(), constructingBodyWithBlock: { (formData: AFMultipartFormData!) -> Void in
                    let dicFiles = files! as NSDictionary
                    let allKeys = dicFiles.allKeys as! [String]
                    for name in allKeys {
                        let theData = dicFiles[name] as! NSData
                        formData.appendPartWithFileData(theData, name: name, fileName: name, mimeType: "image/png")
                    }
                    }, success: task.success, failure: task.failed)
            }else{
                httpManager.POST(wholeURL, parameters: task.query(), success: task.success, failure: task.failed)
            }
        }else{
            httpManager.GET(wholeURL, parameters: task.query(), success: task.success, failure: task.failed)
        }
        
    }
}
