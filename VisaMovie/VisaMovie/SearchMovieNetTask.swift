//
//  SearchMovieNetTask.swift
//  VisaMovie
//
//  Created by Jiao on 23/7/16.
//  Copyright © 2016 Jiao. All rights reserved.
//

import UIKit

class MovieInfo : NSObject {
    var id = 0
    var adult : Bool?
    var title = ""
    var genreIds : [Int]?
    var rating : Int?
    var releaseDate : String?
    var imageUrl : String?
    var backdropUrl : String?
    var overview : String?
    var originalLanguage : String?
    var companyName : String?
    var country : String?
    
    static func parseDictionaryToInfo(dic : NSDictionary) -> MovieInfo{
        let oneMovie = MovieInfo()
        if let tmp = dic["adult"] as? Bool{
            oneMovie.adult = tmp
        }
        if let tmp = dic["genre_ids"] as? [Int]{
            oneMovie.genreIds = tmp
        }
        if let tmp = dic["id"] as? Int{
            oneMovie.id = tmp
        }
        if let tmp = dic["original_language"] as? String{
            oneMovie.originalLanguage = tmp
        }
        if let tmp = dic["title"] as? String{
            oneMovie.title = tmp
        }
        if let tmp = dic["overview"] as? String{
            oneMovie.overview = tmp
        }
        if let tmp = dic["release_date"] as? String{
            oneMovie.releaseDate = tmp
        }
        if let tmp = dic["vote_average"] as? Int{
            oneMovie.rating = tmp
        }
        if let tmp = dic["poster_path"] as? String{
            oneMovie.imageUrl = OMDBImageBaseURL + tmp
        }
        if let tmp = dic["backdrop_path"] as? String{
            oneMovie.backdropUrl = OMDBImageBaseURL + tmp
        }
        if let tmp = dic["production_companies"] as? NSDictionary{
            if let tmpName = tmp["name"] as? String{
                oneMovie.companyName = tmpName
            }
        }
        if let tmp = dic["production_countries"] as? NSDictionary{
            if let tmpName = tmp["name"] as? String{
                oneMovie.country = tmpName
            }
        }
        
        return oneMovie
    }
}

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
    
    static func parseResultToMovieInfoList(json : NSDictionary) -> [MovieInfo] {
        var infoList = [MovieInfo]()
        
        if let array = json["results"] as? NSArray {
            for one in array {
                if let dic = one as? NSDictionary {
                    let oneMovie = MovieInfo.parseDictionaryToInfo(dic)
                    infoList.append(oneMovie)
                }
            }
        }
        return infoList
    }

}
