//
//  BaseViewController.swift
//  Recipes
//
//  Created by Sang Le on 9/25/18.
//  Copyright © 2018 Sang Le. All rights reserved.
//

import UIKit

/// Used to separate between controller and view
class BaseController<T: UIView>: UIViewController {
    let root = T()
    
    override func loadView() {
        view = root
    }
}
