//
//  SecurityView.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import SwiftUI

struct SecurityView: View {
    @EnvironmentObject private var onboardingViewModel: OnboardingViewModel
    let onFinish: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [Color.indigo.opacity(0.1), Color.blue.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 240, height: 200)
                        .padding(.top, 50)
                    
                    
                    VStack(spacing: 20) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.indigo)
                        
                        HStack(spacing: 12) {
                            Image(systemName: "icloud.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.blue)
                            
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.green)
                            
                            Image(systemName: "faceid")
                                .font(.system(size: 30))
                                .foregroundColor(.indigo)
                        }
                    }
                }
                
                VStack(spacing: 16) {
                    Text("Seguridad y Respaldo")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                    
                    Text("Tu información protegida y respaldada en todo momento")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    InfoCard(
                        icon: "lock.fill",
                        title: "Información Encriptada",
                        description: "Protección de datos de clientes",
                        color: .indigo
                    )
                    
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                VStack(spacing: 12) {
                    ActionButton(title: "Comenzar a Usar Mi Tiendita", action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            onboardingViewModel.completeOnboarding()
                            onFinish()
                        }
                    })
                    Button(action: {
                        onBack()
                    }) {
                        Text("Atrás")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
}
