//
//  StopViewController.swift
//  SimpleETA
//
//  Created by Joseph Herkness on 4/11/17.
//  Copyright © 2017 Joseph Herkness. All rights reserved.
//

import UIKit

class StopsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var segmentButton = UISegmentedControl()
    
    var companyIndex:Int!
    var route: Route!
    var selectedDirection: String!
    var stopNames = [String]()
    var urlString:String = ""
    let urlStringSouth:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        segmentButton = UISegmentedControl(items: [route.direction1, route.direction2])
        
        selectDirection(direction: route.direction1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stopsCell")
        
        view.addSubview(segmentButton)
        view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stopNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopsCell", for: indexPath)
        cell.textLabel?.text = self.stopNames[indexPath.row]
        
        return cell
    }
    
    @IBAction func directionButtonClick(_ sender: UISegmentedControl) {
        //When the button is pressed reload the view
        switch segmentButton.selectedSegmentIndex {
        case 0:
            selectDirection(direction: route.direction1)
        case 1:
            selectDirection(direction: route.direction2)
        default:
            break
        }
    }
    
    func configureWithRoute(route: Route) {
        self.route = route
    }
    
    func selectDirection(direction: String) {
        selectedDirection = direction
        
        urlString = "http://ec2-204-236-211-33.compute-1.amazonaws.com:8080/companies/\(companyIndex!)/routes/\(route.id)/\(direction)/weekday/1/stops"
        let jsonFetcher = JSONfetcher()
        let url = jsonFetcher.getSourceUrl(apiUrl: urlString)
        
        //Call the api asynchronously
        jsonFetcher.callApi(url: url) { data in
            
            //Parse the data
            let parser = customJSONparser(companyIndex: self.companyIndex)
            self.stopNames = parser.getDirectionOneStops(data)
            self.tableView.reloadData()
            
            //If weekday doesn't work do everyday
            if(self.stopNames == []) {
                self.everydaySelectDirection(direction: direction)
            }
        }
    }
    
    func everydaySelectDirection(direction: String) {
        selectedDirection = direction
        
        urlString = "http://ec2-204-236-211-33.compute-1.amazonaws.com:8080/companies/\(companyIndex!)/routes/\(route.id)/\(direction)/everyday/1/stops"
        let jsonFetcher = JSONfetcher()
        let url = jsonFetcher.getSourceUrl(apiUrl: urlString)
        
        //Call the api asynchronously
        jsonFetcher.callApi(url: url) { data in
            
            //Parse the data
            let parser = customJSONparser(companyIndex: self.companyIndex)
            self.stopNames = parser.getDirectionOneStops(data)
            self.tableView.reloadData()
        }
    }
}
