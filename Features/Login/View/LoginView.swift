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
                            //await login()
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
                    destination: DashboardView(),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
