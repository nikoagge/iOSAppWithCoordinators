//
//  Storyboarded.swift
//  iOSAppWithCoordinators
//
//  Created by Nikolas Aggelidis on 25/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: className) as! Self
    }
}
