//
//  BaseCoordinator.swift
//  iOSAppWithCoordinators
//
//  Created by Nikolas Aggelidis on 25/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

protocol BaseCoordinator {
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start() 
}
