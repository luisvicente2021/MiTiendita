//
//  ClientManagementView.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import SwiftUI

struct ClientManagementView: View {
    let onNext: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.1), Color.cyan.opacity(0.1)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 240, height: 200)
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    Image(systemName: "person.text.rectangle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    HStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.cyan)
                        
                        Image(systemName: "doc.text.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blue)
                        
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                }
            }
            
            VStack(spacing: 16) {
                Text("Registro Completo de Clientes")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                
                
                Text("Guarda toda la información importante de tus clientes de forma segura")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal, 30)
            }
            
            VStack(spacing: 16) {
                InfoCard(
                    icon: "camera.fill",
                    title: "Fotos de Identificación",
                    description: "Toma fotos del INE o identificación oficial",
                    color: .blue
                )
                
                InfoCard(
                    icon: "phone.fill",
                    title: "Datos de Contacto",
                    description: "Teléfono, dirección y referencias",
                    color: .green
                )
                
                InfoCard(
                    icon: "doc.text.fill",
                    title: "Historial Completo",
                    description: "Consulta compras y pagos anteriores",
                    color: .orange
                )
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            NavigationButtons(onBack: {
                onBack()
                print("Atras")
            }, onNext: {
                onNext()
                print("Adelante")
            })
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
        }
        .padding()
    }
}
