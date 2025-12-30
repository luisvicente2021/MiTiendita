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
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T {
            let entityName = String(describing: type)
            let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
            return T(entity: entity, insertInto: context)
        }
    
    /// Guarda un objeto después de modificarlo
       func save() throws {
           guard context.hasChanges else { return }
           
           do {
               try context.save()
               print("✅ Datos guardados exitosamente")
           } catch {
               context.rollback()
               print("❌ Error al guardar: \(error)")
               throw CoreDataError.saveFailed
           }
       }
    
    // MARK: - READ (Leer)
        
        /// Obtiene todos los objetos de un tipo
        func fetchAll<T: NSManagedObject>(_ type: T.Type) throws -> [T] {
            let entityName = String(describing: type)
            let fetchRequest = NSFetchRequest<T>(entityName: entityName)
            
            do {
                let results = try context.fetch(fetchRequest)
                print("✅ \(results.count) registros de \(entityName) obtenidos")
                return results
            } catch {
                print("❌ Error al obtener \(entityName): \(error)")
                throw CoreDataError.fetchFailed
            }
        }
    
    // MARK: - UPDATE (Actualizar)
        
        /// Actualiza un objeto (simplemente modifica sus propiedades y guarda)
        func update<T: NSManagedObject>(_ object: T) throws {
            guard context.hasChanges else {
                print("⚠️ No hay cambios para actualizar")
                return
            }
            
            do {
                try context.save()
                print("✅ Objeto actualizado exitosamente")
            } catch {
                context.rollback()
                print("❌ Error al actualizar: \(error)")
                throw CoreDataError.updateFailed
            }
        }
        
        // MARK: - DELETE (Eliminar)
        
        /// Elimina un objeto específico
        func delete<T: NSManagedObject>(_ object: T) throws {
            context.delete(object)
            
            do {
                try context.save()
                print("✅ Objeto eliminado exitosamente")
            } catch {
                context.rollback()
                print("❌ Error al eliminar: \(error)")
                throw CoreDataError.deleteFailed
            }
        }
}


enum CoreDataError: Error, LocalizedError {
    case saveFailed
    case fetchFailed
    case updateFailed
    case deleteFailed
    case countFailed
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .saveFailed:
            return "Error al guardar los datos"
        case .fetchFailed:
            return "Error al obtener los datos"
        case .updateFailed:
            return "Error al actualizar los datos"
        case .deleteFailed:
            return "Error al eliminar los datos"
        case .countFailed:
            return "Error al contar los registros"
        case .notFound:
            return "Registro no encontrado"
        }
    }
}
