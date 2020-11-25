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
    var selectedFriend: Int? = nil
    
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
    
    private func configure(friend: Friend, position: Int) {
        guard let friendTableViewController = UIStoryboard(name: "Friend", bundle: nil).instantiateViewController(identifier: "FriendTableViewController") as? FriendTableViewController else {
            fatalError("Unable to create FriendTableViewController")
        }
        selectedFriend = position
        friendTableViewController.homeTableViewControllerDelegate = self
        friendTableViewController.friend = friend
        
        navigationController?.pushViewController(friendTableViewController, animated: true)
    }
    
    func update(friend: Friend) {
        guard let selectedFriend = selectedFriend else { return }
        friendsArray[selectedFriend] = friend
        tableView.reloadData()
        saveData()
    }
    
    @objc private func addFriend() {
        let friend = Friend()
        friendsArray.append(friend)
        tableView.insertRows(at: [IndexPath(row: friendsArray.count - 1, section: 0)], with: .automatic)
        saveData()
        
        configure(friend: friend, position: friendsArray.count - 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendsArray[indexPath.row].name
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = friendsArray[indexPath.row].timeZone
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: Date())
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(friend: friendsArray[indexPath.row], position: indexPath.row)
    }
}
