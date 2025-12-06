//
//  ClienteCardView.swift
//  MiTiendita
//
//  Created by luisr on 28/10/25.
//

import SwiftUI

struct ClienteCardView: View {
    let cliente: Persona
    
    var body: some View {
        HStack(spacing: 16) {
            
            // FOTO
            Group {
                if let data = cliente.fotoPersonaURL,
                   let uiImage = UIImage(data: data) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                    
                } else {
                    Image("vanilla")
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            
            // INFORMACIÓN DEL CLIENTE
            VStack(alignment: .leading, spacing: 6) {
                Text(cliente.nombreCompleto)
                    .font(.headline)
                
                Label(cliente.telefono, systemImage: "phone.fill")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Label("Crédito: $\(cliente.limiteCredito, specifier: "%.2f")", systemImage: "creditcard.fill")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            // INDICADOR DE PAGO
            Circle()
                .fill((cliente.haPagado ?? false) ? Color.green : Color.red)
                .frame(width: 12, height: 12)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.1), radius: 3)
        )
    }
}
