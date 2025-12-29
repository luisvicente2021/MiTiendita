//
//  PreferencesView.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject private var viewModel: RegisterPersonViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Paso 3 de 4")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 20)
                    
                    VStack(spacing: 8) {
                        Text("Preferencias")
                            .font(.title2.bold())
                        
                        Text("Personaliza la configuración de tu tienda")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    VStack(spacing: 20) {
                        // Respaldo en la nube
                        PreferenceCard(
                            icon: "icloud.fill",
                            title: "Respaldo en la nube",
                            description: "Mantén tus datos seguros y sincronizados",
                            isOn: $viewModel.cloudBackup
                        )
                        
                        // Requerir PIN
                        PreferenceCard(
                            icon: "lock.shield.fill",
                            title: "Requerir PIN al abrir",
                            description: "Protege tu información con un PIN",
                            isOn: $viewModel.requirePin
                        )
                        
                        // Monto máximo de fiado
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Monto máximo de fiado")
                                        .font(.headline)
                                    Text("Límite por cliente")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Text("$\(Int(viewModel.maxFiado))")
                                    .font(.title3.bold())
                                    .foregroundColor(.blue)
                            }
                            
                            Slider(value: $viewModel.maxFiado, in: 100...10000, step: 100)
                                .tint(.blue)
                            
                            HStack {
                                Text("$100")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("$10,000")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        )
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 100)
                }
            }
            
            // Botones de navegación
            navigationButtons
        }
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 12) {
            Button(action: {
                withAnimation {
                    coordinator.push(.summary)
                }
            }) {
                Text("Siguiente")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}

#Preview {
    // PreferencesView()
}
