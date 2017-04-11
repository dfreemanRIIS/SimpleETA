//
//  RoutesTableViewController.swift
//  SimpleETA
//
//  Created by Joseph Herkness on 4/11/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class RouteTableViewController: UITableViewController {
    
    var routes:[Route] = []
    var companyIndex = -1
    var urlString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the cell so we can dequeue it
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "routeCell")
        
        //Fetch
        urlString = "http://ec2-204-236-211-33.compute-1.amazonaws.com:8080/companies/\(companyIndex)/routes"
        let jsonFetcher = JSONfetcher()
        let url = jsonFetcher.getSourceUrl(apiUrl: urlString)
        
        //Call the api asynchronously
        jsonFetcher.callApi(url: url) { data in
            
            //Parse the data
            let parser = customJSONparser(companyIndex: self.companyIndex)
            self.routes = parser.getRoutes(fromJSONString: data)
            
            //Reload the tableview
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)
        cell.textLabel?.text = self.routes[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stopsVC = StopsViewController()
        stopsVC.companyIndex = self.companyIndex
        stopsVC.configureWithRoute(route: routes[indexPath.row])
        navigationController?.pushViewController(stopsVC, animated: true)
    }

}
