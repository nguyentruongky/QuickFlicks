//
//  NowPlayingViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/28/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit
import Answers

class MoviesOutletController: UIViewController {

    lazy var searchResults = [Movie]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewModeSegment: UISegmentedControl!
    @IBOutlet weak var movieGallery: MovieGallery!
    @IBOutlet weak var movieList: MovieList!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    var movies = [Movie]()
    var isLoading = false
    var page = 1
    var totalPages = 2
    var api : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.hidden = true

        movieGallery.delegate = self
        movieList.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        movieList.hidden = viewModeSegment.selectedSegmentIndex != 0
        movieGallery.hidden = !movieList.hidden
        
        viewModeSegment.addTarget(self, action: #selector(changeViewMode), forControlEvents: .ValueChanged)
        
        tableView.registerNib(UINib(nibName: "MovieListCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MovieListCell")
        
        searchBar.showsCancelButton = false
        
        retryButton.addTarget(self, action: #selector(loadMoreMovies), forControlEvents: .TouchUpInside)
        errorView.hidden = true
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
        
        self.view.animateLoadingView()
        MoviesOutletCommunicator.getData(api, page: page, successAction: { [unowned self] (movies, currentPage, totalPage) in
            self.isLoading = false
            self.view.stopLoading()
            self.page += 1
            self.totalPages = totalPage
            self.movies.appendContentsOf(movies)
            self.updateList(self.movies)
        }) {
            self.isLoading = false
            self.showErrorMessage("Network error")
            self.view.stopLoading()
            print("fail")
        }
        
    }
    
    

}
