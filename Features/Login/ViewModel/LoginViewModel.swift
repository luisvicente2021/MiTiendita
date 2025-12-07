//
//  LoginViewModel.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//


import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var clientes: [Persona] = []
    private let getClientesUseCase: GetClientesUseCase
    private let loginUseCase: LoginUseCase
    private var errorMessage = ""
    private var  isLoggedIn = false
    
    init(getClientesUseCase: GetClientesUseCase, loginUseCase: LoginUseCase) {
        self.getClientesUseCase = getClientesUseCase
        self.loginUseCase = loginUseCase
    }
    
    func login(email: String, password: String) async {
        do {
            try await loginUseCase.execute(email: email, password: password)
            isLoggedIn = true
        } catch {
            errorMessage = "Usuario o password incorrecto"
        }
    }
    
    func loadClientes() async {
        do {
            clientes = try await getClientesUseCase.execute()
        } catch {
            errorMessage = "Error al cargar clientes"
        }
    }
}
