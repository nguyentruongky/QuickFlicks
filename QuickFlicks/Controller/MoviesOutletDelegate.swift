//
//  NowPlayingDelegate.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/29/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

protocol ShowMovieDetailDelegate {
    
    func didShowMovieDetail(controller: UIViewController)
    
    func loadMoreMovies() 
}

extension MoviesOutletController: UITableViewDelegate, UITableViewDataSource, ShowMovieDetailDelegate, UISearchControllerDelegate, UISearchBarDelegate  {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func didShowMovieDetail(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        tableView.hidden = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        performSelector(#selector(search), withObject: searchText, afterDelay: 0.5)
    }
    
    func search(keyword: String) {
        
        NowPlayingCommunicator.search(keyword) { (ids, totalPage) in
            
            print(ids)
        }
    }
    
}