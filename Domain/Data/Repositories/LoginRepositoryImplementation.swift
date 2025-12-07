//
//  LoginRepositoryImplementation.swift
//  MiTiendita
//
//  Created by luisr on 29/11/25.
//

import Foundation
final class LoginRepositoryImplementation: LoginRepository {
    
    @Published var personas: [Persona] = []
    @Published var errorMessage: String = ""
    private let dataSource: CustomerLocalDataSource
    
    init(dataSource: CustomerLocalDataSource) {
        self.dataSource = dataSource
    }
    
    func login(email: String, password: String) {
        print("Login")
    }
}
