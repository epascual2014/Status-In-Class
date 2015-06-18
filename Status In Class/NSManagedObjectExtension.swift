//
//  NSManagedObjectExtension.swift
//  Status In Class
//
//  Created by Edrick Pascual on 6/17/15.
//  Copyright (c) 2015 Edrick Pascual. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    
    class func newObjectInContext(context: NSManagedObjectContext) -> NSManagedObject {
        
        // turn any class into a string and guaranteeing it
        let entityName = NSStringFromClass(self).componentsSeparatedByString(".").last!
        
        // convert the User & Update class entities and convert it to the class NSManagedObject must be cast later.
        let object = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context) as! NSManagedObject
        
        return object
    }
    
    
    
}