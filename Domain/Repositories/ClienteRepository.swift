//
//  ClienteRepository.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//

import Foundation

protocol PersonaRepository {
    func getClientes() throws -> [Persona]
    func createCliente(_ cliente: Persona) throws
    func updateCliente(_ cliente: Persona) throws
    func deleteCliente(id: String) throws
}
