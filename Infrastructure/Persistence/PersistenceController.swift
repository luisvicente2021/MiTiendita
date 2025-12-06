//
//  PersistenceController.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ClienteModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("❌ Error cargando Core Data: \(error)")
            } else {
                // Imprime la ruta del SQLite para depuración
                if let storeURL = self.container.persistentStoreCoordinator.persistentStores.first?.url {
                    print("📁 Ruta del SQLite:", storeURL)
                }
            }
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
}
