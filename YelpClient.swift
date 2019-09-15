//
//  YelpClient.swift
//  PTSearch
//
//  Created by Divya Sivakumar on 9/14/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//


import UIKit

import AFNetworking
import BDBOAuth1Manager

// You can register for Yelp API keys here: https://www.yelp.com/developers/v3/manage_app
let yelpAPIKey = "dlf4SUjSHNkL6E65DUGSK12ZlO5NGzu2VaqkM0R6ewbLcIBQSpc4mY-B4cZabya2bocOQVnnwdVxeAoAzlf7jSir8h_Wy2LkQqH5c4GAQwl08uPG5qH-3l0MpU18XXYx"

enum YelpSortMode: String {
    case best_match, rating, review_count, distance
}

class YelpClient: AFHTTPRequestOperationManager {
    var apiKey: String!
    
    //MARK: Shared Instance
    
    static let sharedInstance = YelpClient(yelpAPIKey: yelpAPIKey)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(yelpAPIKey: String) {
        self.apiKey = yelpAPIKey
        
        let baseUrl = URL(string: "https://api.yelp.com/v3/")
        super.init(baseURL: baseUrl)
        requestSerializer.setValue("Bearer \(self.apiKey!)", forHTTPHeaderField: "Authorization")
    }
    
    func searchWithTerm(_ term: String, locationParam: String, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
    
        return searchWithTerm(term, locationParam: locationParam, sort: YelpSortMode.rating, categories: nil, openNow: nil, completion: completion)
    }
    
    func searchWithTerm(_ term: String, locationParam: String, sort: YelpSortMode?, categories: [String]?, openNow: Bool?, completion: @escaping ([Business]?, Error?) -> Void) -> AFHTTPRequestOperation {
        // For additional parameters, see https://www.yelp.com/developers/documentation/v3/business_search
        
        var parameters: [String : AnyObject] = ["term": term as AnyObject, "location": locationParam as AnyObject]
        
        if sort != nil {
            parameters["sort_by"] = sort!.rawValue as AnyObject?
        }
        
        if categories != nil && categories!.count > 0 {
            parameters["categories"] = (categories!).joined(separator: ",") as AnyObject?
        }
        
        if openNow != nil {
            parameters["open_now"] = openNow! as AnyObject
        }
        
        print(parameters)
        
        return self.get("businesses/search", parameters: parameters,
                        success: { (operation: AFHTTPRequestOperation, response: Any) -> Void in
                            if let response = response as? [String: Any]{
                                let dictionaries = response["businesses"] as? [NSDictionary]
                                if dictionaries != nil {
                                    completion(Business.businesses(array: dictionaries!), nil)
                                }
                            }
        },
                        failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                            completion(nil, error)
        })!
    }
}

