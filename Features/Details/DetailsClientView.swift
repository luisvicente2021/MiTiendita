//
//  Cliente.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//

import SwiftUI

struct ClienteDetalleView: View {
    let cliente: Persona
    @State private var mostrarEditarCliente = false
    @State private var mostrarNuevoPrestamo = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header con información básica
                ClienteHeaderView(cliente: cliente)
                    .padding(.bottom, 20)
                
                // Resumen financiero
                ResumenFinancieroView(cliente: cliente)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                
                // Lista de préstamos
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Préstamos Activos")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: { mostrarNuevoPrestamo = true }) {
                            Label("Nuevo", systemImage: "plus.circle.fill")
                                .font(.subheadline.weight(.semibold))
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    
                  //  if cliente.haPagado.isEmpty {
                    //    EmptyStateView()
                    //} else {
                      //  ForEach(cliente.prestamos) { prestamo in
                            //PrestamoCardView(prestamo: prestamo)
                              //  .onTapGesture {
                                    //prestamoSeleccionado = prestamo
                               // }
                       // }
                    //}
                }
                .padding(.bottom, 100)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { mostrarEditarCliente = true }) {
                    Image(systemName: "pencil.circle.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
            }
        }
        .sheet(isPresented: $mostrarEditarCliente) {
            // Aquí irá la vista de editar cliente
            Text("Editar Cliente")
        }
        .sheet(isPresented: $mostrarNuevoPrestamo) {
            // Aquí irá la vista de nuevo préstamo
            Text("Nuevo Préstamo")
        }
        //.sheet(item: $prestamoSeleccionado) { prestamo in
          //  PrestamoDetalleView(prestamo: prestamo)
       // }
    }
}


