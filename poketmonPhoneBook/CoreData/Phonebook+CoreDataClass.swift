//
//  Phonebook+CoreDataClass.swift
//  poketmonPhoneBook
//
//  Created by 김기태 on 4/22/25.
//
//

import Foundation
import CoreData

@objc(Phonebook)
public class Phonebook: NSManagedObject {
    public static let className = "Phonebook"
    public enum Key {
        static let name = "name"
        static let phoneNum = "phoneNum"
        static let image = "image"
    }

}
