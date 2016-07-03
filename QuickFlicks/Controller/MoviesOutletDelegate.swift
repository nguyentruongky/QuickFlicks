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
    
    func refreshList()
    
    func showErrorMessage(withMessage: String)
    
    func hideErrorMessage()
}

extension MoviesOutletController: UITableViewDelegate, UITableViewDataSource, ShowMovieDetailDelegate, UISearchControllerDelegate, UISearchBarDelegate  {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movie = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieListCell", forIndexPath: indexPath) as! MovieListCell
        cell.setupData(movie)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = searchResults[indexPath.row]
        let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MovieDetailViewController") as! MovieDetailViewController
        detail.data = movie
        didShowMovieDetail(detail)
    }
    
    func refreshList() {
        page = 1
        loadMoreMovies()
    }
    
    func didShowMovieDetail(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showErrorMessage(withMessage: String) {
        errorMessageLabel.text = withMessage
        errorView.hidden = false
        performSelector(#selector(hideErrorMessage), withObject: nil, afterDelay: 5)
    }
    
    func hideErrorMessage() {
        errorView.hidden = true
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        tableView.hidden = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        tableView.hidden = true
        searchResults.removeAll()
        tableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText != "" else {
            searchResults.removeAll()
            tableView.reloadData()
            tableView.hidden = true
            return
        }
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        performSelector(#selector(search), withObject: searchText, afterDelay: 0.5)
    }
    
    func search(keyword: String) {
        
        searchResults.removeAll()
        tableView.reloadData()
        
        MoviesOutletCommunicator.search(keyword) { (ids, totalPage) in
            
            print(ids)
            for id in ids {
                MoviesOutletCommunicator.getDetailWithMovieId(id, successHandler: { (movie) in
                    self.searchResults.append(movie)
                    self.tableView.reloadData()
                    }, failHandler: { 
                        
                })
            }
        }
    }
    
}