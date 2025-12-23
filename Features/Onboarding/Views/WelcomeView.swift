//
//  WelcomeView.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                
                Image(systemName: "storefront.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                VStack(spacing: 16) {
                    Text("Bienvenido a Mi Tiendita")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    
                    Text("Configura tu tienda en unos simples pasos y comienza a llevar el control de tus fiados de manera fácil y organizada.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 12) {
                    FeatureBadge(icon: "checkmark.circle.fill", text: "Registro rápido de clientes")
                    FeatureBadge(icon: "checkmark.circle.fill", text: "Control de pagos y deudas")
                    FeatureBadge(icon: "checkmark.circle.fill", text: "Respaldo en la nube")
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                Button(action: {
                    coordinator.push(.clientManagement)
                }) {
                    Text("Comenzar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            }
            .padding()
            
            // Botón de Saltar en la esquina superior derecha
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                     //   AppState.completeOnboarding()
                        
                    }) {
                        Text("Saltar")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 60)
                }
                Spacer()
            }
        }
    }
}
