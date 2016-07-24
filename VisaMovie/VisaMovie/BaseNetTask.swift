//
//  BaseNetTask.swift
//  VisaMovie
//
//  Created by jiao qing on 23/7/16.
//  Copyright © 2016 jiao qing. All rights reserved.
//

import UIKit

enum HTTPTaskMethod {
    case Get
    case Post
}

class BaseNetTask: NSObject {
    var success = {(task : NSURLSessionDataTask, response : AnyObject?) -> Void in }
    var failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in }
    
    func uri() -> String!
    {
        return ""
    }
    
    func method() -> HTTPTaskMethod
    {
        return HTTPTaskMethod.Get
    }
    
    func query() -> [NSObject : AnyObject]!
    {
        return Dictionary<String , AnyObject>()
    }
    
    func files() -> [NSObject : AnyObject]? {
        return nil
    }
}
