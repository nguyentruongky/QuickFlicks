//
//  MovieGridCell.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/1/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class MovieGridCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    override func awakeFromNib() {
        thumbnailImageView.awakeFromNib()
    }
    
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
    }
    
    func setupData(movie: Movie) {
        let api = smallPoster + movie.posterUrl
        Alamofire.request(.GET, api)
            .responseImage { [unowned self] response in
                if let image = response.result.value {
                    self.thumbnailImageView.image = image
                }
        }
    }


}
