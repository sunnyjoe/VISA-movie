//
//  DataContainer.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

let cachedGenreKey = "cachedGenreKey"

class DataContainer: NSObject {
    static let sharedInstace = DataContainer()
    
    var genreList : [MovieGenre]?
    
    func getGenreList(completion : (([MovieGenre]) -> Void)){
        if genreList != nil {
            completion(genreList!)
            return
        }
        if let cachedDic = getCachedGenre(){
            genreList = GenreListNetTask.parseResultToGenreList(cachedDic)
            completion(genreList!)
            return
        }
        
        let one = GenreListNetTask()
        one.success = {(task : NSURLSessionDataTask, responseObject : AnyObject?) -> Void in
            if let data = responseObject as? NSDictionary {
                let movieGenreList = GenreListNetTask.parseResultToGenreList(data)
                completion(movieGenreList)
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print("GenreListNetTask failed")
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
    }
}

extension DataContainer {
    private func getCachedGenre() -> NSDictionary?{
        if let tmp = NSUserDefaults.standardUserDefaults().objectForKey(cachedGenreKey){
            return tmp as? NSDictionary
        }
        return nil
    }
    
    private func storeGenreDictionary(dic : NSDictionary){
        NSUserDefaults.standardUserDefaults().setObject(dic, forKey: cachedGenreKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
