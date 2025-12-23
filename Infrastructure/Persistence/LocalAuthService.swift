//
//  LocalAuthService.swift
//  MiTiendita
//
//  Created by luisr on 21/12/25.
//

import Foundation
import CoreData

final class LocalAuthService {
    // MARK: - Singleton
    static let shared = LocalAuthService()
    
     init() {}
    
    // MARK: - Properties
    private let coreDataManager = CoreDataManager.shared
    private let userDefaults = UserDefaults.standard
    private let currentUserKey = "currentUserId"
    private let isLoggedInKey = "isLoggedIn"
    
    // MARK: - Current User
    
    var currentUserId: String? {
        get { userDefaults.string(forKey: currentUserKey) }
        set { userDefaults.set(newValue, forKey: currentUserKey) }
    }
    
    var isLoggedIn: Bool {
        get { userDefaults.bool(forKey: isLoggedInKey) }
        set { userDefaults.set(newValue, forKey: isLoggedInKey) }
    }
    
    // MARK: - Sign Up (Registro)
    
    func signUp(
        email: String,
        password: String,
        address: String,
        loan: Double,
        phone: String,
        metadata: [String: Any] = [:]
    ) throws -> ClienteMO {
        let context = coreDataManager.context
        
        // Verificar si el email ya existe
        let fetchRequest: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        let existingUsers = try context.fetch(fetchRequest)
        
        if !existingUsers.isEmpty {
            throw LocalAuthError.emailAlreadyExists
        }
        
        // Crear nuevo usuario
        let user = ClienteMO(context: context)
        user.id = UUID()
        user.email = email
        user.password = password
        //user. = hashPassword(password) // ⚠️ En producción usa encriptación real
        user.address = address
        user.loan = loan
        user.phone = phone
        //user.createdAt = Date()
        // Guardar
        try context.save()
        
        print("✅ Usuario registrado: \(email)")
        return user
    }
    
    // MARK: - Sign In (Login)
    
    func signIn(email: String, password: String) throws -> ClienteMO {
        let context = coreDataManager.context
        
        // Buscar usuario por email
        let fetchRequest: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        let users = try context.fetch(fetchRequest)
        
        guard let user = users.first else {
            throw LocalAuthError.invalidCredentials
        }
        
        // Verificar contraseña
        let hashedPassword = hashPassword(password)
        
        guard user.password == hashedPassword else {
            throw LocalAuthError.invalidCredentials
        }
        
        // Guardar sesión
        currentUserId = user.id?.uuidString
        isLoggedIn = true
        
        print("✅ Usuario logueado: \(email)")
        return user
    }
    
    // MARK: - Sign Out (Logout)
    
    func signOut() {
        currentUserId = nil
        isLoggedIn = false
        print("✅ Sesión cerrada")
    }
    
    // MARK: - Get Current User
    
    func getCurrentUser() throws -> ClienteMO? {
        guard let userId = currentUserId else {
            return nil
        }
        
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId)
        
        let users = try context.fetch(fetchRequest)
        return users.first
    }
    
    // MARK: - Check Session
    
    func hasActiveSession() -> Bool {
        return isLoggedIn && currentUserId != nil
    }
    
    // MARK: - Update User
    
    func updateUser(user: Persona) throws {
        let context = coreDataManager.context
        try context.save()
        print("✅ Usuario actualizado")
    }
    
    // MARK: - Delete User
    
    func deleteUser(userId: String) throws {
        let context = coreDataManager.context
        let fetchRequest: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userId)
        
        let users = try context.fetch(fetchRequest)
        
        if let user = users.first {
            context.delete(user)
            try context.save()
            
            // Cerrar sesión si es el usuario actual
            if userId == currentUserId {
                signOut()
            }
            
            print("✅ Usuario eliminado")
        }
    }
    
    // MARK: - FETCH
    func fetchClientes() throws -> [Persona] {
        let context = coreDataManager.context
        let request: NSFetchRequest<ClienteMO> = ClienteMO.fetchRequest()
        let result = try context.fetch(request)
        return result.map { $0.toEntity() }
    }
    
    // MARK: - CREATE
    func createCliente(person: Persona) throws {
        let context = coreDataManager.context
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
    
    
    // MARK: - Password Hashing (Básico - usa algo mejor en producción)
    
    private func hashPassword(_ password: String) -> String {
        // ⚠️ IMPORTANTE: En producción usa CryptoKit o similar
        // Esto es solo para ejemplo
        return password.data(using: .utf8)?.base64EncodedString() ?? password
    }
}

// MARK: - Errors

enum LocalAuthError: Error, LocalizedError {
    case emailAlreadyExists
    case invalidCredentials
    case userNotFound
    case saveFailed
    
    var errorDescription: String? {
        switch self {
        case .emailAlreadyExists:
            return "Este correo ya está registrado"
        case .invalidCredentials:
            return "Correo o contraseña incorrectos"
        case .userNotFound:
            return "Usuario no encontrado"
        case .saveFailed:
            return "Error al guardar"
        }
    }
}
