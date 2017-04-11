//
//  JSONfetcher.swift
//  ETAMock
//
//  Created by Donald Freeman on 3/23/17.
//  Copyright © 2017 Donald Freeman. All rights reserved.
//

import Foundation

class JSONfetcher {
    var url:URL?
    var apiUrl:String?

    func getSourceUrl(apiUrl:String) -> URL {
        url = URL(string:apiUrl)
        return url!
    }
    
    /// Asynchronously retrieves a string representation of data from a given url
    ///
    /// - Parameter url:        A Url object we want data from
    /// - Parameter completion: A closure which is called with the data
    func callApi(url:URL, completion: @escaping (String) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, request, error) in
            DispatchQueue.main.async(){
                guard let data = data,
                    let outputdata = String(data: data, encoding: String.Encoding.utf8) else {
                    completion("")
                    return
                }
                completion(outputdata)
            }
        }).resume()
    }
}
