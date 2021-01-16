//
//  Commit+CoreDataProperties.swift
//  CommitsApp
//
//  Created by Nadia on 16.01.2021.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var sha: String
    @NSManaged public var message: String
    @NSManaged public var url: String
    @NSManaged public var date: Date
    @NSManaged public var author: Author

}

extension Commit : Identifiable {

}
