//
//  LoginRepository.swift
//  MiTiendita
//
//  Created by luisr on 29/11/25.
//

import Foundation

protocol LoginRepository {
    func login(email: String, password: String) async throws
    func fetchClientes() async throws -> [Persona]
}
