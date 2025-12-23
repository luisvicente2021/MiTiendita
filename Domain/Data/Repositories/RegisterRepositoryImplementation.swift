//
//  OnboardingRepositoryImplementation 2.swift
//  MiTiendita
//
//  Created by luisr on 29/11/25.

import Foundation

final class RegisterRepositoryImplementation: RegisterRepository {
    
    private let dataSource: LocalAuthService
    
    init(dataSource: LocalAuthService) {
        self.dataSource = dataSource
    }
    
    func registerPerson(person: Persona){
        do {
            try dataSource.createCliente(person: person)
        } catch {
            print("Ocurrió un error: \(error)")
        }
        
    }
    
}
