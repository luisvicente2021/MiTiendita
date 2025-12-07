//
//  ResumenCard.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//
import SwiftUI

struct ResumenCard: View {
    let titulo: String
    let valor: String
    let icono: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icono)
                .font(.title2)
                .foregroundColor(color)
            
            Text(valor)
                .font(.title3.bold())
                .foregroundColor(.primary)
            
            Text(titulo)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
    }
}
