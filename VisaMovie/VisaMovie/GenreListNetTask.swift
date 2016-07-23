//
//  GenreListNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieGenre : NSObject {
    var id = 0
    var name = ""
}

class GenreListNetTask: BaseNetTask {
    override func uri() -> String!
    {
        return "genre/movie/list"
    }
    
    static func parseResultToGenreList(json : NSDictionary) -> [MovieGenre] {
        var genreList = [MovieGenre]()
        
        if let array = json["genres"] as? NSArray {
            for one in array {
                if let dic = one as? NSDictionary {
                    let oneGenre = MovieGenre()
                    if let tmp = dic["id"] as? Int{
                        oneGenre.id = tmp
                        print(tmp)
                    }
                    if let tmp = dic["name"] as? String{
                        oneGenre.name = tmp
                    }
                    genreList.append(oneGenre)
                }
            }
        }
        return genreList
    }
    
}
