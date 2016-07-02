//
//  MovieDetailCommunication.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/2/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Alamofire


struct MovieDetailCommunicator {

    static func getDetailWithMovieId(id: Int, successHandler: (runTime: Int) -> (), failHandler: () -> ()) {
        
        Alamofire.request(.GET, "https://api.themoviedb.org/3/movie/\(id)", parameters: ["api_key": apiKey])
            .responseJSON { response in
                
                // check return code here
                
                if let value = response.result.value {
                    
                    let runtime = value["runtime"] as! Int
                    successHandler(runTime: runtime)
                }
        }
    
    }
    

}
