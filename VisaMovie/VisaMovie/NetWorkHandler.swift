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
let OMDBImageBaseURL = "http://image.tmdb.org/t/p/w500"

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
        
        let successWrapper = {(wtask : NSURLSessionDataTask, wresponse : AnyObject?) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                task.success(wtask, wresponse)
            }
        }
        let failedWrapper = {(wtask : NSURLSessionDataTask?, werror : NSError) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                task.failed(wtask, werror)
            }
        }
        
        
        if task.method() == HTTPTaskMethod.Post {
            httpManager = httpJSONManager
            httpManager.POST(wholeURL, parameters: task.query(), success: successWrapper, failure: failedWrapper)
        }else{
            httpManager.GET(wholeURL, parameters: task.query(), success: successWrapper, failure: failedWrapper)
        }
        
    }
}
