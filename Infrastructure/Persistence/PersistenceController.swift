//
//  PersistenceController.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import CoreData
import Foundation


final class CoreDataManager {
    // MARK: - Singleton
    static let shared = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ClienteModel") // Nombre de tu .xcdatamodeld
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
            print("✅ Core Data cargado: \(description.url?.absoluteString ?? "")")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Contexto guardado")
            } catch {
                let nsError = error as NSError
                print("❌ Error al guardar contexto: \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Delete All Data (útil para testing)
    func deleteAllData() {
        let entities = persistentContainer.managedObjectModel.entities
        
        for entity in entities {
            guard let entityName = entity.name else { continue }
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                print("✅ Datos eliminados: \(entityName)")
            } catch {
                print("❌ Error al eliminar \(entityName): \(error)")
            }
        }
    }
}
