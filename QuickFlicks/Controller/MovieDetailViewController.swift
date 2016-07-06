//
//  MovieDetailViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/2/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SteviaLayout

class MovieDetailView: UIView {
    
    var posterImageView = UIImageView()
    var contentView = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var rateLabel = UILabel()
    var timeLabel = UILabel()
    var overviewLabel = UILabel()
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        render()
    }
    
    func render() {
        
        backgroundColor = .whiteColor()
        
        // Setup UI, need to clean up later
        // === BEGIN ===
        posterImageView.contentMode = .ScaleAspectFill
        
        contentView.backgroundColor = UIColor.blackColor()
        contentView.alpha = 0.8
        
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        dateLabel.textColor = UIColor.whiteColor()
        dateLabel.font = dateLabel.font.fontWithSize(13)
        rateLabel.textColor = UIColor.whiteColor()
        rateLabel.font = rateLabel.font.fontWithSize(13)
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.font = timeLabel.font.fontWithSize(13)
        overviewLabel.textColor = UIColor.whiteColor()
        overviewLabel.font = overviewLabel.font.fontWithSize(13)
        overviewLabel.numberOfLines = 0
        // === END ===
        
        sv(
            posterImageView.sv(
                contentView.sv(
                    titleLabel,
                    dateLabel,
                    rateLabel,
                    timeLabel,
                    overviewLabel
                )
            )
        )
        
        layout(
            0,
            |posterImageView|,
            0
        )
        
        posterImageView.layout(
            |-32-contentView.height(150)-32-|,
            0
        )
        
        contentView.layout(
            0,
            |-8-titleLabel-8-|,
            5,
            |-8-dateLabel-8-|,
            20,
            |-8-rateLabel-timeLabel-8-|,
            5,
            |-8-overviewLabel-8-|,
            0
        )
    }
    
    func fieldStyle(f:UITextField) {
        f.borderStyle = .RoundedRect
        f.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        f.returnKeyType = .Next
    }
    
    func passwordFieldStyle(f:UITextField) {
        f.secureTextEntry = true
        f.returnKeyType = .Done
    }
    
    func buttonSytle(b:UIButton) {
        b.backgroundColor = .lightGrayColor()
    }
    
    func loginTapped() {
        //Do something
    }
}

class MovieDetailViewController: UIViewController {
    
    var movieDetailView: MovieDetailView!
    var data: Movie!
    
    override func viewDidAppear(animated: Bool) {
        
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = MovieDetailView()
        }

        self.view = MovieDetailView()
        movieDetailView = view as! MovieDetailView
        
        movieDetailView.titleLabel.text = data.title
        movieDetailView.dateLabel.text = data.releaseDate
        movieDetailView.rateLabel.text = String(data.voteAverage)
        Alamofire.request(.GET, "\(largePoster)\(data.posterUrl)", parameters: ["api_key": apiKey])
            
           .responseData { (data) in
            self.movieDetailView.posterImageView.image = UIImage(data: data.data!)
        }
        movieDetailView.overviewLabel.text = data.overview
        MovieDetailCommunicator.getDetailWithMovieId(data.id, successHandler: { (runTime) in
            
            let h = runTime / 60
            let m = runTime % 60
            let min = m % 60 == 0 ? "" : "\(m) mins"
            self.movieDetailView.timeLabel.text = "\(h) hr \(min)"
            }) {
        }
    }
}
