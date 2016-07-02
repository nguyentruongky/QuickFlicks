//
//  NowPlayingViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MoviesOutletController: UIViewController {

    var searchResults: [Movie]!
    @IBOutlet weak var seachbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    
    @IBOutlet weak var viewModeSegment: UISegmentedControl!
    @IBOutlet weak var movieGallery: MovieGallery!
    @IBOutlet weak var movieList: MovieList!
    
    var movies = [Movie]()
    var isLoading = false
    var page = 1
    var totalPages = 2
    var api : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: self)
        tableView.hidden = true

        movieGallery.delegate = self
        movieList.delegate = self
        
        movieList.hidden = viewModeSegment.selectedSegmentIndex != 0
        movieGallery.hidden = !movieList.hidden
        
        viewModeSegment.addTarget(self, action: #selector(changeViewMode), forControlEvents: .ValueChanged)
    }
    
    func changeViewMode() {
        updateList(movies)
        movieList.hidden = viewModeSegment.selectedSegmentIndex != 0
        movieGallery.hidden = !movieList.hidden
    }
    
    func updateList(movies: [Movie]) {
        viewModeSegment.selectedSegmentIndex != 0 ?
            movieGallery.setupData(movies) :
            movieList.setupData(movies)
    }
    
    func loadMoreMovies() {
        
        guard isLoading == false else { print("return at isloading"); return }
        guard page < totalPages else { print("return at page < totalpages"); return }
        isLoading = true
        
        NowPlayingCommunicator.getData(api, page: page, successAction: { [unowned self] (movies, currentPage, totalPage) in
            self.isLoading = false
            self.view.stopLoading()
            self.page += 1
            self.totalPages = totalPage
            self.movies.appendContentsOf(movies)
            self.updateList(self.movies)
        }) {
            self.isLoading = false
            self.view.stopLoading()
            print("fail")
        }
        
    }
    
    

}
