//
//  Untitled.swift
//  MiTiendita
//
//  Created by luisr on 29/11/25.
//

import Foundation

struct StoreConfiguration: Codable {
    let ownerName: String
    let storeName: String
    let phone: String
    let email: String?
    let pin: String
    let street: String
    let neighborhood: String
    let city: String
    let postalCode: String
    let cloudBackup: Bool
    let requirePin: Bool
    let maxFiado: Double
    let createdAt: Date
    
    init(
        ownerName: String,
        storeName: String,
        phone: String,
        email: String?,
        pin: String,
        street: String,
        neighborhood: String,
        city: String,
        postalCode: String,
        cloudBackup: Bool,
        requirePin: Bool,
        maxFiado: Double
    ) {
        self.ownerName = ownerName
        self.storeName = storeName
        self.phone = phone
        self.email = email
        self.pin = pin
        self.street = street
        self.neighborhood = neighborhood
        self.city = city
        self.postalCode = postalCode
        self.cloudBackup = cloudBackup
        self.requirePin = requirePin
        self.maxFiado = maxFiado
        self.createdAt = Date()
    }
}
