//
//  MovieList.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/2/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class MovieList: KViewBase {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    var api: String!
    var delegate: ShowMovieDetailDelegate!
    var isLoading = false
    lazy var movies = [Movie]()
    var page = 1
    var totalPages = 2
    
    override func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(UINib(nibName: "MovieListCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "MovieListCell")
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func refresh(sender:AnyObject) {
        movies.removeAll()
        delegate.refreshList()
    }
    
    func setupData(movies: [Movie]) {
        
        self.movies = movies
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

}
