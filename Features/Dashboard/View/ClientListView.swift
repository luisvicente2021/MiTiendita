//
//  ClientListView.swift
//  MiTiendita
//
//  Created by luisr on 30/10/25.
//

import SwiftUI

struct ClientesListView: View {
    @StateObject var viewModel = DashboardViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                
                if viewModel.clientes.isEmpty {
                    EmptyStateView(
                        icon: "person.2.slash",
                        title: "No hay clientes",
                        message: "Agrega tu primer cliente para comenzar"
                    )
                    .padding()
                    
                } else {
                    ForEach(viewModel.clientes) { cliente in
                        NavigationLink(destination: ClienteDetalleView(cliente: cliente)) {
                            ClienteCardView(cliente: cliente)
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                }
                
            }
            
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Clientes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Acción para agregar cliente
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.loadClientes()
        }
        .refreshable {
            viewModel.loadClientes()
        }
    }
}
