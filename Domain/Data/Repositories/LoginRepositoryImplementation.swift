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
    
    func login(email: String, password: String) async {
        do {
            let success = try  dataSource.loginLocal(email: email, password: password)
            
            if success {
                print("Login correcto")
            } else {
                print("Credenciales incorrectas")
            }
            
        } catch {
            print("❌ Error en login local:", error)
        }
    }
    
    
    func fetchClientes() async throws -> [Persona] {
        
        try dataSource.fetchClientes()
        
    }
    
}
