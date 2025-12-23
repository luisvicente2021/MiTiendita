//
//  PersonaRepositoryImplemebtation.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//

import Foundation

final class ClienteRepositoryImpl: PersonaRepository {
    
    private let localDataSource: LocalAuthService
    
    init(localDataSource: LocalAuthService) {
        self.localDataSource = localDataSource
    }
    
    func getClientes() throws -> [Persona] {
        try localDataSource.fetchClientes()
    }
    
    func createCliente(_ cliente: Persona) throws {
        try localDataSource.createCliente(person: cliente)
    }
    
    func updateCliente(_ cliente: Persona) throws {
        try localDataSource.updateUser(user: cliente)
    }
    
    func deleteCliente(id: String) throws {
        try localDataSource.deleteUser(userId: id)
    }
}

