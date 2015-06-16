//
//  User.swift
//  Status In Class
//
//  Created by Edrick Pascual on 6/15/15.
//  Copyright (c) 2015 Edrick Pascual. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var bio: String
    @NSManaged var city: String
    @NSManaged var handleName: String
    @NSManaged var link: String
    @NSManaged var userName: String
    @NSManaged var updates: NSSet

}
