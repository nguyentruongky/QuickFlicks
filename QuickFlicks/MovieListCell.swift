//
//  MovieListCell.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/2/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Alamofire

class MovieListCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
 
    func setupData(movie: Movie) {
        let api = smallPoster + movie.posterUrl
        posterImageView.af_setImageWithURL(NSURL(string: api)!)
        
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
//        Alamofire.request(.GET, api)
//            .responseImage { [unowned self] response in
//                if let image = response.result.value {
//                    self.posterImageView.image = image
//                }
//        }
    }
}
