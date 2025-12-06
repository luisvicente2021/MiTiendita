//
//  ClientesViewModel.swift
//  MiTiendita
//
//  Created by luisr on 04/12/25.
//


import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    
    @Published var clientes: [Persona] = []
    
    private let dataSource: CustomerLocalDataSource
    
    init(dataSource: CustomerLocalDataSource = CustomerLocalDataSource()) {
        self.dataSource = dataSource
        loadClientes()
    }
    
    func loadClientes() {
        do {
            let result = try dataSource.fetchClientes()
            self.clientes = result
        } catch {
            print("❌ Error cargando clientes:", error)
        }
    }
    
    func deleteCliente(_ id: String) {
        do {
            try dataSource.deleteCliente(id: id)
            loadClientes()  // Recargar lista después de borrar
        } catch {
            print("❌ Error al eliminar:", error)
        }
    }
}
