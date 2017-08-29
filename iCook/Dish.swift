//
//  Dish.swift
//  iCook
//
//  Created by Niranjan Ravichandran on 03/11/15.
//  Copyright © 2015 Team. All rights reserved.
//

import Foundation
import Parse

struct Dish {
    
    let name: String?
    let cuisine: String?
    let ingredients: String?
    let dishImage: PFFile?
    let availabilityDuration: String?
    let cost: Int?
    let recipe: String?
    let userId: String!
    
    init(dishObject: PFObject){
        name = dishObject["Name"] as? String
        cuisine = dishObject["Cuisine"]as? String
        ingredients = dishObject["Ingredients"] as? String
        availabilityDuration = dishObject["Availability_Duration"] as? String
        cost = dishObject["Cost"] as? Int
        recipe = dishObject["Recipe"] as? String
        dishImage = dishObject["Photo"] as? PFFile
        userId = dishObject["UserId"] as? String
    }
}