//
//  UserModel.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 17/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import Foundation
import Parse

struct User {
    
    let firstName: String!
    let lastName: String!
    let phone: String!
    let email: String!
    let profilePic: PFFile?
    let role: Int!
    let menu: String?
    let cuisine: String?
    let rating: Int?
    let homeDelivery: Bool!
    let description: String?
    let address: String?
    let city: String?
    let state: String?
    
    init(responseObject: PFObject){
        
        self.firstName = responseObject["FirstName"] as? String
        self.lastName = responseObject["LastName"] as? String
        self.phone = responseObject["PhoneNumber"] as? String
        self.menu = responseObject["Menu"] as? String
        self.email = responseObject["email"] as? String
        self.role = responseObject["Role"] as? Int
        self.profilePic = responseObject["Photo"] as? PFFile
        self.cuisine = responseObject["Cuisine"] as? String
        self.rating = responseObject["Ratings"] as? Int
        self.homeDelivery = responseObject["HomeDelivery"] as! Bool
        self.description = responseObject["Description"] as? String
        self.address = responseObject["Address_StreetName"] as? String
        self.city = responseObject["Address_City"] as? String
        self.state = responseObject["Address_State"] as? String
    }
    
}