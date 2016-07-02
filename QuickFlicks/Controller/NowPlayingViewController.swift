//
//  NowPlayingViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, ShowMovieDetailDelegate {

    var loadingAnimationView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    var isLoading = false
    lazy var movies = [Movie]()
    var page = 1
    var totalPages = 2
    
    @IBOutlet weak var movieGallery: MovieGallery!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        movieGallery.setupData("https://api.themoviedb.org/3/movie/now_playing")
        movieGallery.delegate = self
    }
    
    func loadMoreMovies() {
        
        guard isLoading == false else { print("return at isloading"); return }
        
        guard page < totalPages else { print("return at page < totalpages"); return }
        
        isLoading = true 
        isLoading = true
        NowPlayingCommunicator.getData("https://api.themoviedb.org/3/movie/now_playing", page: page, successAction: { [unowned self] (movies, currentPage, totalPage) in
            self.isLoading = false
            self.view.stopLoading()
            self.page += 1
            self.totalPages = totalPage
            self.movies.appendContentsOf(movies)
            self.collectionView.reloadData()
            print(self.page)
        }) {
            self.isLoading = false 
            self.view.stopLoading()
            print("fail roi")
        }

    }
    
    func didShowMovieDetail(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }

}
