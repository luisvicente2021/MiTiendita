//
//  ClienteMapper.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//

import Foundation
import CoreData

extension ClienteMO {
    func toEntity() -> Persona {
        Persona(
            id: self.id ?? UUID(),
            nombreCompleto: self.name ?? "",
            telefono: self.phone ?? "",
            direccion: self.address ?? "",
            correo: self.email ?? "",
            limiteCredito: self.creditLimit,
            notas: self.notes,
            fotoPersonaURL: self.photoPerson,
            fotoINEURL: self.inePhoto,
            prestamoActivo: self.activeLoan,
            montoPrestamoActual: self.loan,
            haPagado: self.isPay
        )
    }
}

extension ClienteMO {
    func toManagedObject(in context: NSManagedObjectContext) -> ClienteMO {
        let mo = ClienteMO(context: context)
        mo.id = self.id
        mo.name = self.name
        mo.phone = self.phone
        mo.address = self.address
        mo.email = self.email
        mo.creditLimit = self.creditLimit
        mo.notes = self.notes
        mo.photoPerson = self.photoPerson
        mo.inePhoto = self.inePhoto
        mo.activeLoan = self.activeLoan
        mo.loan = self.loan
        mo.isPay = self.isPay
        
        return mo
    }
}



extension Persona {
    func toManagedObject(in context: NSManagedObjectContext) -> ClienteMO {
        let mo = ClienteMO(context: context)
        mo.id = self.id
        mo.name = self.nombreCompleto
        mo.phone = self.telefono
        mo.address = self.direccion
        mo.email = self.correo
        mo.creditLimit = self.limiteCredito
        mo.notes = self.notas
        mo.photoPerson = self.fotoPersonaURL
        mo.inePhoto = self.fotoINEURL
        mo.activeLoan = self.prestamoActivo ?? false
        mo.loan = self.montoPrestamoActual ?? 0.0
        mo.isPay = self.haPagado ?? false
        return mo
    }
}
