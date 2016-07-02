//
//  NowplayingCommunicator.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import Alamofire

struct NowPlayingCommunicator {
    
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