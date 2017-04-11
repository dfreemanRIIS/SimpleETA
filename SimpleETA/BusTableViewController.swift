//
//  ViewController.swift
//  SimpleETA
//
//  Created by Joseph Herkness on 4/11/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class BusTableViewController: UITableViewController {
    
    let busses = ["Smart", "DDot", "Reflex"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Company"
        navigationController?.navigationBar.isTranslucent = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "busCell")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busCell", for: indexPath)
        cell.textLabel?.text = busses[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let routeVC = RouteTableViewController()
        routeVC.companyIndex = indexPath.row + 1
        navigationController?.pushViewController(routeVC, animated: true)
    }
}




