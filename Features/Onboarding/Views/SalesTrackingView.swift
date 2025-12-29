//
//  Sales.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import SwiftUI

struct SalesTrackingView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [Color.purple.opacity(0.1), Color.pink.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 240, height: 200)
                    .padding(.top, 50)
                
                
                VStack(spacing: 20) {
                    Image(systemName: "tshirt.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "tag.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.pink)
                        
                        Image(systemName: "cart.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.purple)
                        
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                }
            }
            
            VStack(spacing: 16) {
                Text("Venta de Ropa Simplificada")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                Text("Registra cada venta rápidamente y mantén tu inventario actualizado")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                InfoCard(
                    icon: "barcode.viewfinder",
                    title: "Registro Rápido",
                    description: "Agrega productos y precios al instante",
                    color: .purple
                )
                
                InfoCard(
                    icon: "bag.fill",
                    title: "Control de Inventario",
                    description: "Sabe qué tienes disponible en todo momento",
                    color: .blue
                )
                
                InfoCard(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Análisis de Ventas",
                    description: "Conoce tus productos más vendidos",
                    color: .green
                )
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            NavigationButtons(onNext: {
                print("Adelante")
                coordinator.push(.security)
            })
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .padding()
    }
}
