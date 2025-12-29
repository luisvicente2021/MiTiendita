//
//  SummaryView.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject private var registerViewModel: RegisterPersonViewModel
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    var onFinish: ((Persona) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Paso 4 de 4")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 20)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Revisa tu Información")
                            .font(.title2.bold())
                        
                        Text("Asegúrate de que todo esté correcto antes de finalizar")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    VStack(spacing: 16) {
                        // Encargado
                        SummarySection(
                            icon: "person.circle.fill",
                            title: "Encargado",
                            items: [
                                ("Nombre", registerViewModel.ownerName),
                                ("Tienda", registerViewModel.storeName),
                                ("Teléfono", registerViewModel.phone),
                                ("Email", registerViewModel.email.isEmpty ? "No especificado" : registerViewModel.email)
                            ]
                        )
                        
                        // Dirección
                        SummarySection(
                            icon: "map.circle.fill",
                            title: "Dirección",
                            items: [
                                ("Calle", registerViewModel.street),
                                ("Colonia", registerViewModel.neighborhood),
                                ("Ciudad", registerViewModel.city),
                                ("CP", registerViewModel.postalCode)
                            ]
                        )
                        
                        // Preferencias
                        SummarySection(
                            icon: "gearshape.circle.fill",
                            title: "Preferencias",
                            items: [
                                ("Respaldo en nube", registerViewModel.cloudBackup ? "Activado" : "Desactivado"),
                                ("PIN requerido", registerViewModel.requirePin ? "Sí" : "No"),
                                ("Máximo de fiado", "$\(Int(registerViewModel.maxFiado))")
                            ]
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 100)
                }
            }
            
            // Botones finales
            finalButtons
        }
        .alert("¡Configuración Completa!", isPresented: $registerViewModel.showSuccessAlert) {
            Button("Continuar") {
                
                
            }
        } message: {
            Text("Tu tienda ha sido configurada exitosamente. Ahora puedes iniciar sesión.")
        }
        .alert("Error", isPresented: .constant(registerViewModel.errorMessage != nil)) {
            Button("OK") {
                registerViewModel.errorMessage = nil
            }
        } message: {
            if let error = registerViewModel.errorMessage {
                Text(error)
            }
        }
        .fullScreenCover(isPresented: $registerViewModel.onboardingCompleted) {
           // LoginView()  en processo
        }
    }
    
    private var finalButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                let nuevaPersona = Persona(id: UUID(), nombreCompleto: registerViewModel.ownerName, telefono: registerViewModel.phone, direccion: registerViewModel.street, correo: registerViewModel.email, limiteCredito: registerViewModel.maxFiado, fotoPersonaURL: registerViewModel.photoData)
                
                Task {
                    await registerViewModel.register(nuevaPersona: nuevaPersona)
                    coordinator.push(.dashboard)
                    onFinish?(nuevaPersona)
                }
            }) {
                HStack {
                    if registerViewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(0.8)
                    }
                    Text(registerViewModel.isLoading ? "Finalizando..." : "Finalizar Configuración")
                        .font(.headline)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(registerViewModel.isLoading ? Color.gray : Color.blue)
                .cornerRadius(12)
            }
            .disabled(registerViewModel.isLoading)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}

#Preview {
}
