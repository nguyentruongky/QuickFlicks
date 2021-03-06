//
//  NowPlayingViewController.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 7/3/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    @IBOutlet weak var containerViewController: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! UINavigationController
        let outletController = controller.viewControllers[0] as! MoviesOutletController
        outletController.api = "https://api.themoviedb.org/3/movie/now_playing"
    }
}
