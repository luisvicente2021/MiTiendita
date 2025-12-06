//
//  Persona.swift
//  MiTiendita
//
//  Created by luisr on 12/08/25.
//

import Foundation
import UIKit

struct Persona: Codable, Identifiable {
    var id: UUID // que la DB lo genere
    var nombreCompleto: String
    var telefono: String
    var direccion: String
    var correo: String
    var limiteCredito: Double
    var notas: String?
    var fotoPersonaURL: Data?
    var fotoINEURL: String?
    var prestamoActivo: Bool?  // true si tiene préstamo pendiente
    var montoPrestamoActual: Double?
    var haPagado: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nombreCompleto = "nombre_completo"
        case telefono
        case direccion
        case correo
        case limiteCredito = "limite_credito"
        case notas
        case fotoPersonaURL = "foto_persona_url"
        case fotoINEURL = "foto_ine_url"
        case prestamoActivo
        case montoPrestamoActual
        case haPagado = "hapagado"
    }
}



struct PersonaInsertable: Encodable {
    let id: UUID
    let nombre_completo: String
    let telefono: String
    let direccion: String
    let correo: String
    let limite_credito: Double
    let notas: String?
    let foto_persona_url: Data?
    let foto_ine_url: String?
    let montoPrestamoActual: Double?
    
    
    init(from persona: Persona) {
        self.id = persona.id
        self.nombre_completo = persona.nombreCompleto
        self.telefono = persona.telefono
        self.direccion = persona.direccion
        self.correo = persona.correo
        self.limite_credito = persona.limiteCredito
        self.notas = persona.notas
        self.foto_persona_url = persona.fotoPersonaURL
        self.foto_ine_url = persona.fotoINEURL
        self.montoPrestamoActual = persona.montoPrestamoActual
        
    }
}

extension Persona {
    var insertable: PersonaInsertable {
        PersonaInsertable(from: self)
    }
}





struct PersonaUpdate: Encodable {
    let nombrecompleto: String?
    let telefono: String?
    let direccion: String?
    let correo: String?
    let limitecredito: Double?
    let notas: String?
    let fotopersonaurl: Data?
    let fotoineurl: String?
    let prestamoactivo: Bool?
    let montoprestamoactual: Double?
    let hapagado: Bool?
}


extension PersonaUpdate {
    init(from p: Persona) {
        self.nombrecompleto = p.nombreCompleto
        self.telefono = p.telefono
        self.direccion = p.direccion
        self.correo = p.correo
        self.limitecredito = p.limiteCredito
        self.notas = p.notas
        self.fotopersonaurl = p.fotoPersonaURL
        self.fotoineurl = p.fotoINEURL
        self.prestamoactivo = p.prestamoActivo
        self.montoprestamoactual = p.montoPrestamoActual
        self.hapagado = p.haPagado
    }
}


final class PersonasManager: ObservableObject {
    @Published var personas: [Persona] = []
}
