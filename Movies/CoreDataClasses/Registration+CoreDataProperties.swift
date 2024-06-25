//
//  Registration+CoreDataProperties.swift
//  Movies
//
//  Created by Vaibhav Gawde on 16/06/24.
//
//

import Foundation
import CoreData


extension Registration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Registration> {
        return NSFetchRequest<Registration>(entityName: "Registration")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension Registration : Identifiable {

}
