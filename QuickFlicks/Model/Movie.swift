//
//  Movie.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

struct Movie {

    var adult : Bool
    var id : Int
    var language : String
    var overview: String
    var posterUrl: String
    var voteCount: Int
    var voteAverage: Float
    var title: String
    var releaseDate : String
    var runtime : Int?

    init(rawData: AnyObject) {
        
        let poster = rawData["poster_path"] as? String
        let backdrop = rawData["backdrop_path"] as? String
        if let poster = poster {
            posterUrl = poster
        }
        else {
            posterUrl = backdrop!
        }
        
        runtime = rawData["runtime"] as? Int
        
        releaseDate = rawData["release_date"] as! String
        adult = rawData["adult"] as! Bool
        id = rawData["id"] as! Int
        language = rawData["original_language"] as! String
        let overviewValue = rawData["overview"]  as? String
        overview = overviewValue == nil ? "" : overviewValue!
        title = rawData["title"] as! String
        voteCount = rawData["vote_count"] as! Int
        voteAverage = rawData["vote_average"] as! Float
    }
}