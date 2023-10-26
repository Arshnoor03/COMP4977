//
//  CoreDataManager.swift
//  Arshnoor_practice
//
//  Created by Arshnoor Kaur Boparai on 2023-10-25.
//

import Foundation

import CoreData

class CoreDataManager{
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        
        //default database in SQLite
        persistentContainer.loadPersistentStores{
            (description, error) in
            if let err =  error {
                fatalError("Coare data store failed: \(err.localizedDescription)")
            }
        }
    }
    
    func saveMovie(title: String, year: Int){
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        movie.year = Int16(year)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error)")
        }
    }
    
    func getAllMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func deleteMovie(movie: Movie){
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch{
            persistentContainer.viewContext.rollback()
            print("Failed to delete movie \(error)")
        }
    }
    
    func updateMovie(){
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to update teh movie \(error)")
        }
    }
    
}
