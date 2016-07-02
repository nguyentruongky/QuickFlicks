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
    }
    func setupData(movies: [Movie]) {
        
        self.movies = movies
        tableView.reloadData()
    }
    

}
