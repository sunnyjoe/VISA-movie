//
//  SearchMovieNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class SearchMovieNetTask: BaseNetTask {
    var year : Int?
    var genre : Int?
    
    override func uri() -> String!
    {
        return "search/movie"
    }
    
    override func query() -> [NSObject : AnyObject]!{
        var dic = Dictionary<String , AnyObject>()
        if let tmp = genre {
            dic["year"] = tmp
        }
        if let tmp = year{
            dic["genre"] = tmp
        }
        return dic
    }
}
