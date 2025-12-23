//
//  GetClientesUseCase.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//
import Foundation

final class GetClientesUseCase {
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
   // func execute() async throws -> [Persona] {
    //    try await repository.fetchClientes()
    //}
}
