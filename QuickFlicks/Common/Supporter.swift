//
//  Supporter.swift
//  QuickFlicks
//
//  Created by Ky Nguyen on 6/30/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import JGProgressHUD
import Foundation

let keyLoading = 104
struct Supporter {
    
}

extension UIView {
    
    func animateLoadingView() {
        
        let loading = JGProgressHUD(style: .Dark)
        loading.tag = keyLoading
        loading.textLabel.text = "Loading"
        loading.showInView(self)
    }
    
    func stopLoading() {
        let view = self.viewWithTag(keyLoading) as? JGProgressHUD
        view?.dismissAnimated(true)
        
    }
}

extension UIScrollView {
    
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
    
}