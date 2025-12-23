//
//  CustomerLocalDataSource.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//

import Foundation
import CoreData
/*

final class CustomerLocalDataSource {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
    }
    
    // MARK: - FETCH
    func fetchClientes() throws -> [Persona] {
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        let result = try context.fetch(request)
        return result.map { $0.toEntity() }
    }
    
    // MARK: - CREATE
    func createCliente(person: Persona) throws {
        
        let cliente = ClienteMO(context: context)
        
        cliente.id = person.id
        cliente.name = person.nombreCompleto
        cliente.phone = person.telefono
        cliente.email = person.correo
        cliente.address = person.direccion
        cliente.creditLimit = person.limiteCredito
        cliente.activeLoan = person.prestamoActivo ?? false
        cliente.loan = person.montoPrestamoActual ?? 0.0
        cliente.isPay = person.haPagado ?? false
        cliente.notes = person.notas
        cliente.photoPerson = person.fotoPersonaURL
        cliente.inePhoto = person.fotoINEURL
        
        print("➡️ Cliente listo para guardar:")
        print("ID:", cliente.id ?? "nil")
        print("Nombre:", cliente.name ?? "nil")
        print("Teléfono:", cliente.phone ?? "nil")
        print("Dirección:", cliente.address ?? "nil")
        
        try context.save()
        
        print("✅ Cliente guardado correctamente en Core Data")
    }
    
    // MARK: - UPDATE
    func updateCliente(_ cliente: Persona) throws {
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", cliente.id as CVarArg)
        
        if let existing = try context.fetch(request).first {
            
            existing.name = cliente.nombreCompleto
            existing.phone = cliente.telefono
            existing.address = cliente.direccion
            existing.email = cliente.correo
            existing.creditLimit = cliente.limiteCredito
            existing.notes = cliente.notas
            existing.photoPerson = cliente.fotoPersonaURL
            existing.inePhoto = cliente.fotoINEURL
            existing.activeLoan = cliente.prestamoActivo ?? false
            existing.loan = cliente.montoPrestamoActual ?? 0.0
            existing.isPay = cliente.haPagado ?? false
            
            try context.save()
            
            print("✏️ Cliente actualizado: \(existing.name ?? "")")
        }
    }
    
    // MARK: - DELETE
    func deleteCliente(id: String) throws {
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let object = try context.fetch(request).first {
            context.delete(object)
            try context.save()
            print("🗑 Cliente con ID \(id) eliminado.")
        }
    }
    
    // MARK: - DEBUG (Ver Todo lo que hay en CoreData)
    func debugPrintClientes() {
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        
        do {
            let result = try context.fetch(request)
            
            print("\n📌 === CLIENTES EN CORE DATA ===")
            if result.isEmpty {
                print("No hay clientes guardados.")
                return
            }
            
            for c in result {
                print("""
                --------------------------
                ID: \(String(describing: c.id) )
                Nombre: \(c.name ?? "sin nombre")
                Teléfono: \(c.phone ?? "sin teléfono")
                Dirección: \(c.address ?? "sin dirección")
                Correo: \(c.email ?? "sin correo")
                Límite Crédito: \(c.creditLimit)
                Prestamo Activo: \(c.activeLoan)
                Monto Prestamo: \(c.loan)
                --------------------------
                """)
            }
            
        } catch {
            print("❌ Error al obtener clientes:", error)
        }
    }
    
    func loginLocal(email: String, password: String) throws -> Bool {
        
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        request.predicate = NSPredicate(
            format: "email == %@ AND password == %@",
            email, password
        )
        
        return try context.fetch(request).first != nil
    }
}
*/
