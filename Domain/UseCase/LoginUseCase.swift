//
//  LoginUseCase.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//
import Foundation

final class  LoginUseCase {
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }
    
    func execute(email: String, password: String) async throws {
            try await repository.login(email: email, password: password)
        }
}
