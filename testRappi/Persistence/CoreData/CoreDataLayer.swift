//
//  CoreDataLayer.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/08/21.
//

import Foundation

import CoreData
import  UIKit

class CoreDataLayer: NSObject {
    static let context = AppDelegate.context
    static func saveEntitiesInContext() {
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    static func saveMovie(movie: MovieListDetail) {
        let newMovie = NSEntityDescription.insertNewObject(forEntityName: CoreDataEntities.Movies, into: context)
        newMovie.setValue(movie.identifier, forKey: "identifier")
        newMovie.setValue(movie.overview, forKey: "overview")
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    static func saveMovies(movies: [MovieListDetail], section: TypeMovieV3) {
        for mov in movies {
            saveMovie(movie: mov)
        }
    }
    static func getManagedObjectsForEntity(name: String) -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return result.count > 0 ? result as? [NSManagedObject] : nil
        } catch {
            return nil
        }
    }
    static func resetAllRecords(entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error in resetAllRecords \(entity)")
        }
    }
}
