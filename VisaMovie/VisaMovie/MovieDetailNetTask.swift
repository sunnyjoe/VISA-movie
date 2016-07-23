//
//  MovieDetailNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieDetailNetTask: BaseNetTask {
    var movieId : Int = 0
    
    override func uri() -> String!
    {
        return "movie/\(movieId)"
    }
    
    static func parseResultToMovieInfo(json : NSDictionary) -> MovieInfo {
        return MovieInfo.parseDictionaryToInfo(json)
    }
}
