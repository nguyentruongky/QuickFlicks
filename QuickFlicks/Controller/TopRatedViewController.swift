//
//  TopRatedViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/3/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class TopRatedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! UINavigationController
        let outletController = controller.viewControllers[0] as! MoviesOutletController
        outletController.api = "https://api.themoviedb.org/3/movie/top_rated"
    }

}
