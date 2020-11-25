//
//  FriendTableViewController.swift
//  iOSAppWithCoordinators
//
//  Created by Nikolas Aggelidis on 25/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    weak var homeTableViewControllerDelegate: HomeTableViewController?
    var friend: Friend!
    var timeZonesArray = [TimeZone]()
    var selectedTimeZone = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifiers = TimeZone.knownTimeZoneIdentifiers
        
        for identifier in identifiers {
            if let timeZone = TimeZone(identifier: identifier) {
                timeZonesArray.append(timeZone)
            }
        }
        
        let now = Date()
        timeZonesArray.sort {
            if $0.secondsFromGMT(for: now) == $1.secondsFromGMT(for: now) {
                return $0.identifier < $1.identifier
            } else {
                return $0.secondsFromGMT(for: now) < $1.secondsFromGMT(for: now)
            }
        }
        
        selectedTimeZone = timeZonesArray.index(of: friend.timeZone) ?? 0
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return timeZonesArray.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name your friend!"
        } else {
            return "Select their timezone."
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let textTableViewCell = tableView.dequeueReusableCell(withIdentifier: "name", for: indexPath) as? TextTableViewCell  else { fatalError("Couldn't get TextTableViewCell") }
            textTableViewCell.textField.text = friend.name
            
            return textTableViewCell
        } else {
            let defaultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "timezone", for: indexPath)
            defaultTableViewCell.textLabel?.text = timeZonesArray[indexPath.row].identifier
            defaultTableViewCell.detailTextLabel?.text = String(timeZonesArray[indexPath.row].secondsFromGMT(for: Date()))
            if indexPath.row == selectedTimeZone {
                defaultTableViewCell.accessoryType = .checkmark
            } else {
                defaultTableViewCell.accessoryType = .none
            }
            
            return defaultTableViewCell
        }
    }
}
