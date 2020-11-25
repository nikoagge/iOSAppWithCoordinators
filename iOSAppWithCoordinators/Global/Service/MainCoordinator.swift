//
//  MainCoordinator.swift
//  iOSAppWithCoordinators
//
//  Created by Nikolas Aggelidis on 25/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    var childCoordinators = [BaseCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeTableViewController = HomeTableViewController.instantiate(storyboardName: "Home")
        homeTableViewController.mainCoordinator = self
        navigationController.pushViewController(homeTableViewController, animated: false)
    }
    
    func configure(friend: Friend) {
        let friendTableViewController = FriendTableViewController.instantiate(storyboardName: "Friend")
        friendTableViewController.mainCoordinator = self
        friendTableViewController.friend = friend
        navigationController.pushViewController(friendTableViewController, animated: true)
    }
    
    func update(friend: Friend) {
        guard let homeTableViewController = navigationController.viewControllers.first as? HomeTableViewController else { return }
        homeTableViewController.update(friend: friend)
    }
}
