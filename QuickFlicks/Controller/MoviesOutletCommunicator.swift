//
//  NowplayingCommunicator.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire

struct MoviesOutletCommunicator {
    
    static func search(keyword: String, successAction: (ids: [Int], totalPage: Int) -> ()) {
        
        Alamofire.request(.GET, "https://api.themoviedb.org/3/search/keyword", parameters: ["api_key": apiKey, "query": keyword])
        .responseJSON { response in
        
            
            if let value = response.result.value {
                let totalPages = value["total_pages"] as! Int
                let results = value["results"] as! [AnyObject]
                var ids = [Int]()
                for result in results {
                    let id = result["id"] as! Int
                    ids.append(id)
                }
    
                successAction(ids: ids, totalPage: totalPages)
            }
        }
    }
    
    static func getDetailWithMovieId(id: Int, successHandler: (movie: Movie) -> (), failHandler: () -> ()) {
        
        Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/\(id)", parameters: ["api_key": apiKey])
            .responseJSON { response in
                
                // check return code here
                
                if let value = response.result.value {
                
                    let poster = value["poster_path"] as? String
                    let backdrop = value["backdrop_path"] as? String
                    guard backdrop != nil || poster != nil else { return } 
                    
                    let movie = Movie(rawData: value)
                    successHandler(movie: movie)
                }
        }
        
    }
    
    

    
    static func getData(api: String, page: Int, successAction: (movies: [Movie], currentPage: Int, totalPage: Int) -> Void, failAction: () -> ()) {
        
        Alamofire.request(.GET, api, parameters: ["api_key": apiKey, "page": page])
            .responseJSON { response in
                
                // check return code here 
                
                if let value = response.result.value {
                    
                    let currentPage = value["page"] as! Int
                    let totalPage = value["total_pages"] as! Int
                    let results = value["results"] as! [AnyObject]
                    var movies = [Movie]()
                    for result in results {
                        
                        let poster = result["poster_path"] as? String
                        let backdrop = result["backdrop_path"] as? String
                        guard backdrop != nil || poster != nil else { continue }
                        
                        movies.append(Movie(rawData: result))
                    }
                    
                    successAction(movies: movies, currentPage: currentPage, totalPage: totalPage)
                }
        }
        
    }
}