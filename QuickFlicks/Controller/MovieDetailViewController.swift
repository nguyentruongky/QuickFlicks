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

let initDetailView: CGFloat = 200

class MovieDetailView: UIView {
    
    var posterImageView = UIImageView()
    var contentView = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var rateLabel = UILabel()
    var timeLabel = UILabel()
    var overviewLabel = UILabel()
    var scrollView = UIScrollView()
    var scrollContent = UIView()
    
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
        
        titleSytle(titleLabel)
        labelStyle(dateLabel)
        labelStyle(rateLabel)
        labelStyle(timeLabel)
        overviewStyle(overviewLabel)
        // === END ===
        
        sv(
            posterImageView,
            scrollView.sv(
                scrollContent.sv(
                    contentView.sv(
                        titleLabel,
                        dateLabel,
                        rateLabel,
                        timeLabel,
                        overviewLabel
                    )
                )
            )
        )
        
        layout(
            0,
            |posterImageView|,
            0
        )
        
        layout(
            0,
            |scrollView|,
            0
        )
        
        scrollView.layout(
            0,
            |scrollContent| ~ 600,
            0
        )
        
        scrollContent.fillV()
        equalWidths(scrollContent, scrollView)
        
        scrollContent.layout(
            |-32-contentView.height(initDetailView)-32-|,
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
    
    func titleSytle(l: UILabel) {
        
        l.textColor = UIColor.whiteColor()
        l.numberOfLines = 0
        l.font = UIFont.boldSystemFontOfSize(17)
    }
    
    func labelStyle(l: UILabel) {
        
        l.textColor = UIColor.whiteColor()
        l.font = l.font.fontWithSize(13)
    }
    
    func overviewStyle(l: UILabel) {
        
        l.textColor = UIColor.whiteColor()
        l.font = l.font.fontWithSize(13)
        l.numberOfLines = 0
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
        
        setScrollViewContentSize()
    }
    
    func setScrollViewContentSize() {
        
        movieDetailView.overviewLabel.sizeToFit()
        let screenSize = UIScreen.mainScreen().bounds.size
        let detailViewHeight = movieDetailView.overviewLabel.frame.origin.y + movieDetailView.overviewLabel.bounds.height
        movieDetailView.contentView.heightConstraint?.constant = detailViewHeight
        movieDetailView.scrollContent.heightConstraint?.constant = screenSize.height + detailViewHeight - initDetailView
        self.view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        
        setScrollViewContentSize()
    }
}
