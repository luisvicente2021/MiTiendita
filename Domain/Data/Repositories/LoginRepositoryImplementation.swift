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
    private let dataSource: LocalAuthService
    
    init(dataSource: LocalAuthService) {
        self.dataSource = dataSource
    }
    
    func login(email: String, password: String) async {
        do {
            let success = try  dataSource.signIn(email: email, password: password)
            
        } catch {
            print("❌ Error en login local:", error)
        }
    }

    
  //  func fetchClientes() async throws -> [Persona] {
        
    //    try dataSource.fetchClientes()
        
   // }
    
}
