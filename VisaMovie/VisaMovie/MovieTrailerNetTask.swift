//
//  MovieTrailerNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieVideoInfo : NSObject {
    var id = 0
    var key = ""
    var name = ""
    var webSite = ""
    var size = 1
    var type = "Trailer"
}

class MovieVideosNetTask: BaseNetTask {
    var movieId : Int = 0
    
    override func uri() -> String!
    {
        return "movie/\(movieId)/videos"
    }
    
    static func parseResultToMovieVideoList(json : NSDictionary) -> [MovieVideoInfo] {
        var infoList = [MovieVideoInfo]()
        
        if let array = json["results"] as? NSArray {
            for one in array {
                if let dic = one as? NSDictionary {
                    let oneMovie = MovieVideoInfo()
                    infoList.append(oneMovie)
   
                    if let tmp = dic["id"] as? Int{
                        oneMovie.id = tmp
                    }
                    if let tmp = dic["key"] as? String{
                        oneMovie.key = tmp
                    }
                    if let tmp = dic["name"] as? String{
                        oneMovie.name = tmp
                    }
                    if let tmp = dic["site"] as? String{
                        oneMovie.webSite = tmp
                    }
                    if let tmp = dic["size"] as? Int{
                        oneMovie.size = tmp
                    }
                    if let tmp = dic["type"] as? String{
                        oneMovie.type = tmp
                    }
                }
            }
        }
        return infoList
    }

}
