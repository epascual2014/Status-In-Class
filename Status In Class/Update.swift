//
//  Update.swift
//  Status In Class
//
//  Created by Edrick Pascual on 6/15/15.
//  Copyright (c) 2015 Edrick Pascual. All rights reserved.
//

import Foundation
import CoreData

class Update: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var text: String
    @NSManaged var user: User

}
