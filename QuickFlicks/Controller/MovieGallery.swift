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
    lazy var movies = [Movie]()
    
    override func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(UINib(nibName: "MovieGridCell",
            bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "Cell")
    }
    
    func setupData(movies: [Movie]) {
        self.movies = movies
        collectionView.reloadData()
    }
    
    
    

}
