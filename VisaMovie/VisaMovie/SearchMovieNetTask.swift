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
  //  var genres = [MovieGenre]()
    var rating : Int?
    var releaseDate : String?
    var imageUrl : String?
    var backdropUrl : String?
    var overview : String?
    var language : String?
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
        if let tmp = dic["production_companies"] as? NSArray{
            if tmp.count > 0{
                if let dicTmp = tmp[0] as? NSDictionary{
                    if let tmpName = dicTmp["name"] as? String{
                        oneMovie.companyName = tmpName
                    }
                }
            }
        }
        if let tmp = dic["production_countries"] as? NSArray{
            if tmp.count > 0{
                if let dicTmp = tmp[0] as? NSDictionary{
                    if let tmpName = dicTmp["name"] as? String{
                        oneMovie.country = tmpName
                    }
                }
            }
        }
        if let tmp = dic["spoken_languages"] as? NSArray{
            if tmp.count > 0{
                if let dicTmp = tmp[0] as? NSDictionary{
                    if let tmpName = dicTmp["name"] as? String{
                        oneMovie.language = tmpName
                    }
                }
            }
        }
        
        if oneMovie.language == nil {
            if let tmp = dic["original_language"] as? String{
                let locale = NSLocale.init(localeIdentifier: tmp)
                oneMovie.language = locale.displayNameForKey(NSLocaleIdentifier, value: tmp)
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
