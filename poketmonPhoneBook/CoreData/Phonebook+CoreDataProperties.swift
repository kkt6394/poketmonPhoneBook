//
//  Phonebook+CoreDataProperties.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/22/25.
//
//

import Foundation
import CoreData


extension Phonebook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Phonebook> {
        return NSFetchRequest<Phonebook>(entityName: "Phonebook")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNum: String?
    @NSManaged public var image: Data?

}

extension Phonebook : Identifiable {

}
