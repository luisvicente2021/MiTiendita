//
//  ClienteHeaderView.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//
import SwiftUI

struct ClienteHeaderView: View {
    let cliente: Persona
    
    var body: some View {
        VStack(spacing: 16) {
            // Foto de perfil o inicial
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.6), .purple.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 100, height: 100)
                
                if cliente.fotoPersonaURL != nil {
                    // Si hay foto del INE
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                } else {
                    // Inicial del nombre
                    Text(cliente.nombreCompleto.prefix(1).uppercased())
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
            
            // Nombre
            Text(cliente.nombreCompleto)
                .font(.title.bold())
            
            // Información de contacto
            VStack(spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "phone.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(cliente.telefono)
                        .font(.subheadline)
                }
                
                HStack(spacing: 6) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.caption)
                        .foregroundColor(.red)
                    Text(cliente.direccion)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                if cliente.fotoPersonaURL != nil {
                    HStack(spacing: 6) {
                        Image(systemName: "envelope.fill")
                            .font(.caption)
                            .foregroundColor(.green)
                        Text(cliente.correo)
                            .font(.subheadline)
                    }
                }
            }
            .foregroundColor(.secondary)
            
            // Fecha de registro
           // Text("Cliente desde \(cliente.direccion, format: .dateTime.day().month().year())")
             //   .font(.caption)
              //  .foregroundColor(.secondary)
                //.padding(.top, 4)
        }
        .padding(.vertical, 30)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color(.systemBackground), Color(.systemGroupedBackground)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
