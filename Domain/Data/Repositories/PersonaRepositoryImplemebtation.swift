//
//  PersonaRepositoryImplemebtation.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//

import Foundation

final class ClienteRepositoryImpl: PersonaRepository {
    
    private let localDataSource: CustomerLocalDataSource
    
    init(localDataSource: CustomerLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getClientes() throws -> [Persona] {
        try localDataSource.fetchClientes()
    }
    
    func createCliente(_ cliente: Persona) throws {
        try localDataSource.createCliente(person: cliente)
    }
    
    func updateCliente(_ cliente: Persona) throws {
        try localDataSource.updateCliente(cliente)
    }
    
    func deleteCliente(id: String) throws {
        try localDataSource.deleteCliente(id: id)
    }
}

