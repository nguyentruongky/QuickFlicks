//
//  MovieListDelegate.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/2/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension MovieList: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return movies.count }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieListCell", forIndexPath: indexPath) as! MovieListCell
        cell.setupData(movie)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = movies[indexPath.row]
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        detail.data = movie
        delegate.didShowMovieDetail(detail)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.isAtBottom {
            delegate.loadMoreMovies()
        }
    }
}