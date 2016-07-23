//
//  SearchMovieNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class SearchMovieNetTask: BaseNetTask {
    var yearRelased : Int?
    var genre : Int?
    var sortBy = "vote_average.asc"
    
    override func uri() -> String!
    {
        return "discover/movie"
    }
    
    override func query() -> [NSObject : AnyObject]!{
        var dic = Dictionary<String , AnyObject>()
        if let tmp = yearRelased {
            dic["primary_release_year"] = tmp
        }
        if let tmp = genre {
            dic["with_genres"] = tmp
        }
        dic["sort_by"] = sortBy
        return dic
    }
}
