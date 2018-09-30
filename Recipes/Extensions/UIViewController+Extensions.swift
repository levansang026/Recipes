//
//  UIViewController+Extensions.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Add child view controller and its view
    func add(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }
}
