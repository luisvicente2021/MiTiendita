//
//  RegisterUseCase.swift
//  MiTiendita
//
//  Created by luisr on 29/11/25.
import SwiftUI

final class RegisterUseCase: ObservableObject, RegisterRepository {
    
    private let repository: RegisterRepositoryImplementation
    
    init(repository: RegisterRepositoryImplementation) {
        self.repository = repository
    }
    
    func registerPerson(person: Persona) {
        return repository.registerPerson(person: person)
    }
}
