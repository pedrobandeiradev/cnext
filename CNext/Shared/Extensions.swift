//
//  Extensions.swift
//  CNext
//
//  Created by Pedro Bandeira on 06/01/19.
//  Copyright © 2019 Pedro Bandeira. All rights reserved.
//

import UIKit
import Nuke

//Enables the Image view to load an image to itself from a provided URL
extension UIImageView {
    
    func setImageFromUrl(imageURL: URL){        
        Nuke.loadImage(with: imageURL, into: self)
    }
    
}

//Allows the View controller to call a Load Indicator
extension UIViewController {
    
    struct activityIndicator {
        static var viewParent = UIView()
        static var indicator = UIActivityIndicatorView(style: .white)
    }
    
    func configureIndicator() {
        activityIndicator.viewParent.backgroundColor = UIColor(white: 1, alpha: 0.5)
        activityIndicator.viewParent.frame = view.frame
        activityIndicator.indicator.color = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        activityIndicator.indicator.sizeToFit()
        activityIndicator.viewParent.addSubview(activityIndicator.indicator)
        view.addSubview (activityIndicator.viewParent)
        activityIndicator.indicator.center = view.convert(view.center, from:view.superview)
    }
    
    func showLoadIndicator() {
        configureIndicator()
        activityIndicator.viewParent.isHidden = false
        activityIndicator.indicator.startAnimating()
    }
    
    func hideLoadIndicator() {
        activityIndicator.viewParent.isHidden = true
        activityIndicator.indicator.stopAnimating()
    }
}
