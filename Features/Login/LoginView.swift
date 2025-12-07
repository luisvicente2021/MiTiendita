//
//  Loginview.swift
//  MiTiendita
//
//  Created by luisr on 12/08/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = "luisr@test.com"
    @State private var password = "luisr"
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var clientes: [Persona] = []
    @State private var isLoggedIn = false

    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Image("miTiendita")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.top, 40)

                VStack(alignment: .leading, spacing: 15) {
                    TextField("Correo electrónico", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                if isLoading {
                    ProgressView("Iniciando sesión...")
                } else {
                    Button(action: {
                        Task {
                            await login()
                        }
                    }) {
                        Text("Iniciar Sesión")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("ColorPrimario"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }

                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Spacer()

                // Navegación automática a listado de clientes
                NavigationLink(
                    destination: DashboardView(persona: clientes),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Función de login
    func login() async {
        isLoading = true
        errorMessage = nil

        do {
            // Intentar login con Supabase
            try await authManager.login(email: email, password: password)
            
            // Traer listado de clientes desde Supabase
            clientes = try await authManager.fetchClientes()
            
            // Login exitoso
            isLoggedIn = true
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

#Preview {
    LoginView()
}
