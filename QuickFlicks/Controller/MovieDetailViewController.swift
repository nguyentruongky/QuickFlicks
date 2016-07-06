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

class MovieDetailViewController: UIViewController, UIScrollViewDelegate {

//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var posterImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var rateLabel: UILabel!
//    @IBOutlet weak var timeLabel: UILabel!
//    @IBOutlet weak var overviewLabel: UILabel!
//    @IBOutlet weak var overviewScrollView: UIScrollView!
//    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
//    
    var data: Movie!
    
    override func viewDidAppear(animated: Bool) {
        
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

//        titleLabel.text = data.title
//        dateLabel.text = data.releaseDate
//        rateLabel.text = String(data.voteAverage)
//        
//        Alamofire.request(.GET, "\(largePoster)\(data.posterUrl)", parameters: ["api_key": apiKey])
//            
//           .responseData { (data) in
//            self.posterImageView.image = UIImage(data: data.data!)
//        }
//        
//        overviewLabel.text = data.overview + data.overview + data.overview
//        scrollView.delegate = self
//        contentViewHeight.constant = UIScreen.mainScreen().bounds.height
//        overviewScrollView.scrollEnabled = false
//        
//        MovieDetailCommunicator.getDetailWithMovieId(data.id, successHandler: { (runTime) in
//            
//            let h = runTime / 60
//            let m = runTime % 60
//            let min = m % 60 == 0 ? "" : "\(m) mins"
//            self.timeLabel.text = "\(h) hr \(min)"
//            }) {
//        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
    
//        if self.scrollView == scrollView {
//            if scrollView.contentOffset.y  == 0 {
//                UIView.animateWithDuration(0.5, animations: { 
//                    self.overviewScrollView.contentOffset.y = 0
//                })
//            }
//            overviewScrollView.scrollEnabled = scrollView.contentOffset.y != 0
//        }
    }
}
