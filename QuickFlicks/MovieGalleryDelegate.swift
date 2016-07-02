//
//  MovieGalleryDelegate.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/1/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieGallery : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MovieGridCell
        cell.setupData(movies[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let movie = movies[indexPath.row]
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        detail.data = movie
        delegate.didShowMovieDetail(detail)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isAtBottom {
            delegate?.loadMoreMovies()
        }
    }
}