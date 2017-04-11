//
//  Route.swift
//  ETAMock
//
//  Created by Joseph Herkness on 3/28/17.
//  Copyright © 2017 Donald Freeman. All rights reserved.
//

import Foundation

struct Route: Equatable {
    
    var name: String
    var direction1: String
    var direction2: String
    var id: Int
    var routeId: String
    
    static func ==(lhs: Route, rhs: Route) -> Bool {
        return lhs.name == rhs.name &&
            lhs.direction1 == rhs.direction1 &&
            lhs.direction2 == rhs.direction2 &&
            lhs.id == rhs.id &&
            lhs.routeId == rhs.routeId
    }
    
}
