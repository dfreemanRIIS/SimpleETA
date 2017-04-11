//
//  customJSONparser.swift
//  ETAMock
//
//  Created by Donald Freeman on 3/27/17.
//  Copyright © 2017 Donald Freeman. All rights reserved.
//

import Foundation
import SwiftyJSON

class customJSONparser {

    var index = 0

    init(companyIndex:Int) {
        index = companyIndex
    }

    func customParse(_ jsonString:String) -> [String] {
        //Make sure the input isnt null
        if jsonString.characters.count == 0 {
            return []
        }

        //Get indexes of routeID
        let query = "routeID"
        var searchRange = jsonString.startIndex..<jsonString.endIndex
        var indexes: [String.Index] = []
        while let range = jsonString.range(of: query, options: .caseInsensitive, range: searchRange) {
            searchRange = range.upperBound..<searchRange.upperBound
            indexes.append(range.lowerBound)
        }

        var routeIds = [String]()

        //Grab the string for each company
        if(index == 1) {
            //get routeIDs from jsonString
            for thisIndex in indexes {
                let start = jsonString.index(thisIndex, offsetBy: 10)
                let end = jsonString.index(start, offsetBy: 3)
                let range = start..<end
                routeIds.append(jsonString.substring(with: range))
            }
            return routeIds
        }
        if(index == 2) {
            //get routeIDs from jsonString
            for thisIndex in indexes {
                let start = jsonString.index(thisIndex, offsetBy: 15)
                let end = jsonString.index(start, offsetBy: 4)
                let range = start..<end
                routeIds.append(jsonString.substring(with: range))
            }
            return routeIds
        }
        if(index == 3) {
            var temp = false
            //get routeIDs from jsonString
            for thisIndex in indexes {
                var start = jsonString.index(thisIndex, offsetBy: 10)
                var end = jsonString.index(start, offsetBy: 3)
                if(temp == false) {
                    start = jsonString.index(thisIndex, offsetBy: 15)
                    end = jsonString.index(start, offsetBy: 4)
                    temp = true
                }
                let range = start..<end
                routeIds.append(jsonString.substring(with: range))
            }
            return routeIds
        }
        return []
    }

    func getDirectionOneStops(_ jsonString:String) -> [String] {
        //Make sure the input isnt null
        if jsonString.characters.count == 0 {
            return []
        }

        //Get indexes of stopNames
        let query = "stopName"
        var searchRange = jsonString.startIndex..<jsonString.endIndex
        var indexes: [String.Index] = []
        while let range = jsonString.range(of: query, options: .caseInsensitive, range: searchRange) {
            searchRange = range.upperBound..<searchRange.upperBound
            indexes.append(range.lowerBound)
        }

        var stopNames = [String]()

        //get stopNames from jsonString
        for thisIndex in indexes {
            let start = jsonString.index(thisIndex, offsetBy: 11)
            let end = jsonString.index(start, offsetBy: 40)
            let range = start..<end
            var returnString = jsonString.substring(with: range)

            //Make sure you didnt grab any trailing characters
            var running = true
            while running {
                if returnString.range(of:"\"") != nil{
                    returnString = returnString.substring(to: returnString.index(before: returnString.endIndex))
                } else {
                    running = false
                }
            }

            stopNames.append(returnString)
        }

        return stopNames
    }

    func getIds(_ jsonString:String) -> [String] {
        //Make sure the input isnt null
        if jsonString.characters.count == 0 {
            return []
        }

        //Get indexes of stopNames
        let query = ",\"id"
        var searchRange = jsonString.startIndex..<jsonString.endIndex
        var indexes: [String.Index] = []
        while let range = jsonString.range(of: query, options: .caseInsensitive, range: searchRange) {
            searchRange = range.upperBound..<searchRange.upperBound
            indexes.append(range.lowerBound)
        }

        var ids = [String]()

        //get stopNames from jsonString
        for thisIndex in indexes {
            let start = jsonString.index(thisIndex, offsetBy: 6)
            let end = jsonString.index(start, offsetBy: 2)
            let range = start..<end
            var temp = jsonString.substring(with: range)

            //Make sure you didnt grab any trailing characters
            var running = true
            while running {
                if temp.range(of:"}") != nil{
                    temp = temp.substring(to: temp.index(before: temp.endIndex))
                } else {
                    running = false
                }
            }
            ids.append(temp)
        }
        return ids
    }
    
    
    /// Parses a json string for a list of route object
    ///
    /// - Parameter fromJSONString: the string to be parsed
    /// - Returns: a list of route object
    ///
    /// This makes it easier for us to use the data in the controllers
    func getRoutes(fromJSONString: String) -> [Route] {
        
        // Convert string to data, then data to json object
        guard let dataFromString = fromJSONString.data(using: .utf8, allowLossyConversion: false),
            let json = JSON(data: dataFromString).array else {
            return []
        }
        
        // Go over each route and add it to the array
        var routes = [Route]()
        for routeJSON in json {
            let name = routeJSON["routeName"].stringValue
            let direction1 = routeJSON["direction1"].stringValue
            let direction2 = routeJSON["direction2"].stringValue
            let id = routeJSON["id"].intValue
            let routeId = routeJSON["routeID"].stringValue
            let route = Route(name: name, direction1: direction1, direction2: direction2, id: id, routeId: routeId)
            routes.append(route)
        }
        
        return routes
    }
}
