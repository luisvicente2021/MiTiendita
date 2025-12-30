//
//  OnboardingScreen.swift
//  MiTiendita
//
//  Created by luisr on 03/12/25.
//
import Foundation

enum AppRoute: Hashable {
    // Onboarding
    case welcome
    case clientManagement
    case loanManagement
    case salesTracking
    case security
    
    // Auth
    case login
    
    // Register
    case storeOwnerInfo
    case camera
    case storeAddress
    case preferences
    case summary
    
    // Main App
    case dashboard
    /*case clientes
    case clienteDetail(id: String)
    case registrarCliente
    case pagos
    case registrarPago
    case settings*/
}


