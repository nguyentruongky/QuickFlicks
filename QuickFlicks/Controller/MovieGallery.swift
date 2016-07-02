//
//  MovieGallery.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/1/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieGallery: KViewBase {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var delegate: ShowMovieDetailDelegate!
    var isLoading = false
    lazy var movies = [Movie]()
    var page = 1
    var totalPages = 2
    var api : String!
    func setupData(api: String) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.api = api
        collectionView.registerNib(UINib(nibName: "MovieGridCell",
            bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Cell")
    }
    
    func loadMoreMovies() {
        
        guard isLoading == false else { print("return at isloading"); return }
        
        guard page < totalPages else { print("return at page < totalpages"); return }
        
        isLoading = true
        //        view.animateLoadingView()
        isLoading = true
        NowPlayingCommunicator.getData(api, page: page, successAction: { [unowned self] (movies, currentPage, totalPage) in
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
    

}
