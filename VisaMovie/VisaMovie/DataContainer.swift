//
//  DataContainer.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

let cachedGenreKey = "cachedGenreKey"
let cachedGenreTimeKey = "cachedGenreTimeKey"

let refreshGenreListInterval = 24 * 3600 * 1000 * 10 //10 days

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
                self.storeGenreDictionary(data)
                let movieGenreList = GenreListNetTask.parseResultToGenreList(data)
                completion(movieGenreList)
            }
        }
        one.failed = {(task : NSURLSessionDataTask?, error : NSError) -> Void in
            print(error.description)
        }
        
        NetWorkHandler.sharedInstance.sendNetTask(one)
    }
    
    func getGenreNamesFromId(ids : [Int]?, completion : ((String?) -> Void)) {
        if ids == nil {
            completion(nil)
            return
        }
        
        let completion = {(list : [MovieGenre]) -> Void in
            var combine : String?
            for one in list {
                if ids!.contains(one.id) {
                    if combine == nil{
                        combine = ""
                    }
                    combine = combine! + " " + one.name
                }
            }
            completion(combine)
        }
        
        DataContainer.sharedInstace.getGenreList(completion)
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
    
    private func getLastRefreshCachedGenreTime() -> UInt64{
        if let tmp = NSUserDefaults.standardUserDefaults().objectForKey(cachedGenreTimeKey){
            let n = tmp as! NSNumber
            return n.unsignedLongLongValue
        }
        return 0
    }
    
    private func storeLastRefreshGenreListTime(time : UInt64){
        NSUserDefaults.standardUserDefaults().setObject(NSNumber(unsignedLongLong: time), forKey: cachedGenreTimeKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
