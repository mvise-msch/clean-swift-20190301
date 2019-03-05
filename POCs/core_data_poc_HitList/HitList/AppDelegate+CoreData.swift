//
//  AppDelegate+CoreData.swift
//  HitList
//
//  Created by Martin Schnurrenberger, mVISE AG on 05.03.19.
//  Copyright © 2019 Martin Schnurrenberger, mVISE AG. All rights reserved.
//

import UIKit
import CoreData

extension AppDelegate {
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
