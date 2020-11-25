//
//  HomeTableViewController.swift
//  iOSAppWithCoordinators
//
//  Created by Nikolas Aggelidis on 25/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var friendsArray = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        title = "FriendZone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    private func loadData() {
        guard let savedData = UserDefaults.standard.data(forKey: "Friends") else  { return }
        guard let savedFriends = try? JSONDecoder().decode([Friend].self, from: savedData) else { return }
        
        friendsArray = savedFriends
    }
    
    private func saveData() {
        guard let savedData = try? JSONEncoder().encode(friendsArray) else { fatalError("Unable to encode friendsArray data.") }
        
        UserDefaults.standard.setValue(savedData, forKey: "Friends")
    }
    
    @objc private func addFriend() {
        let friend = Friend()
        friendsArray.append(friend)
        tableView.insertRows(at: [IndexPath(row: friendsArray.count - 1, section: 0)], with: .automatic)
        saveData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendsArray[indexPath.row].name
        cell.detailTextLabel?.text = friendsArray[indexPath.row].timeZone.identifier
        
        return cell
    }
}