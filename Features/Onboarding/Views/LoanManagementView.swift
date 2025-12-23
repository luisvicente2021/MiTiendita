//
//  LoanManagementView.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import SwiftUI

struct LoanManagementView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [Color.green.opacity(0.1), Color.mint.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 240, height: 200)
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 30))
                            .foregroundColor(.mint)
                        
                        Image(systemName: "bell.badge.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.orange)
                        
                        Image(systemName: "banknote.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                }
            }
            
            VStack(spacing: 16) {
                Text("Administración de Fiados")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                
                Text("Controla todos los créditos y pagos de tus clientes sin complicaciones")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                InfoCard(
                    icon: "list.bullet.clipboard.fill",
                    title: "Registro de Fiados",
                    description: "Anota cada préstamo con fechas y montos",
                    color: .green
                )
                
                InfoCard(
                    icon: "bell.badge.fill",
                    title: "Recordatorios Automáticos",
                    description: "Notificaciones de pagos pendientes",
                    color: .orange
                )
                
                InfoCard(
                    icon: "chart.pie.fill",
                    title: "Estado de Cuentas",
                    description: "Visualiza quién debe y cuánto al instante",
                    color: .blue
                )
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            NavigationButtons(onBack: {
                print("Boton de Atras")
                coordinator.pop()
            }, onNext: {
                print("Boton de Adelante")
                coordinator.push(.salesTracking)
                
            })
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .padding()
    }
}
