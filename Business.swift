//
//  PTResults.swift
//  PTSearch
//
//  Created by Divya Sivakumar on 9/14/19.
//  Copyright © 2019 Divya Sivakumar. All rights reserved.
//

import Foundation
import UIKit

weak var appDelegate : PTAppDelegate! = (UIApplication.shared.delegate as! PTAppDelegate)
class Business: NSObject {

    let name: String?
    let address: String?
    let ratingStarCount: NSNumber?
    let reviewCount: NSNumber?
    
    init(dictionary: NSDictionary) {

        name = dictionary["name"] as? String
        let location = dictionary["location"] as? NSDictionary
        var address = ""
        if location != nil
        {
            let addressArray = location!["display_address"] as? NSArray
            if addressArray != nil {
                if addressArray!.count > 0 {
                    address = addressArray![0] as! String
                }
                if addressArray!.count > 1 {
                    address += ", " + (addressArray![1] as! String)
                }
            }
        }
        self.address = address
        self.ratingStarCount = dictionary["rating"] as? NSNumber
        reviewCount = dictionary["review_count"] as? NSNumber
    }

    class func businesses(array: [NSDictionary]) -> [Business] {
        var businesses = [Business]()
        for dictionary in array {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
    
    class func searchWithTerm(term: String, locationParam: String, completion: @escaping ([Business]?, Error?) -> Void) {
        _ = YelpClient.sharedInstance.searchWithTerm(term, locationParam: locationParam, completion: completion)
    }
    
    class func searchWithTerm(term: String, locationParam:String, sort: YelpSortMode?, categories: [String]?, completion: @escaping ([Business]?, Error?) -> Void) -> Void {
        _ = YelpClient.sharedInstance.searchWithTerm(term, locationParam:locationParam, sort: sort, categories: categories, openNow: false, completion: completion)
    }
    
}

