//
//  ResumenFinancieroView.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//
import SwiftUI

struct ResumenFinancieroView: View {
    let cliente: Persona
    
    var body: some View {
        HStack(spacing: 12) {
            // Total de deuda
            ResumenCard(
                titulo: "Deuda Total",
                valor: "$\(String(describing: cliente.montoPrestamoActual))",
                icono: "dollarsign.circle.fill",
                color: cliente.montoPrestamoActual ?? 0 > 0 ? .red : .green
            )
            
            // Préstamos activos
            /*ResumenCard(
             titulo: "Préstamos",
             valor: "\(cliente.prestamos.filter { !$0.pagado }.count)",
             icono: "doc.text.fill",
             color: .blue
             )*/
            
            // Historial
            ResumenCard(
                titulo: "Historial",
                valor: "\(String(describing: cliente.haPagado))",
                icono: "clock.fill",
                color: .orange
            )
        }
    }
}

