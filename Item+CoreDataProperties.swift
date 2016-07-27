//
//  Item+CoreDataProperties.swift
//  Todo List
//
//  Created by Tony Saavedra on 7/26/16.
//  Copyright © 2016 Tony Saavedra. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var text: String?
    @NSManaged var completed: Bool

}
