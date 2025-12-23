//
//  AppState.swift
//  MiTiendita
//
//  Created by luisr on 21/12/25.
//

import Foundation
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    // MARK: - Published Properties
    @Published var isAuthenticated = false
    @Published var hasCompletedOnboarding = false
    @Published var isLoading = true
    @Published var currentUser: Persona?
    
    // MARK: - Dependencies
    private let localAuthService: LocalAuthService
    private let userDefaults: UserDefaults
    
    // MARK: - Keys
    private let onboardingKey = "hasCompletedOnboarding"
    
    // MARK: - Initialization
    init(
        localAuthService: LocalAuthService = .shared,
        userDefaults: UserDefaults = .standard
    ) {
        self.localAuthService = localAuthService
        self.userDefaults = userDefaults
        
        // Cargar estado inicial
        self.hasCompletedOnboarding = userDefaults.bool(forKey: onboardingKey)
        
        // Verificar autenticación
        Task {
            await checkAuthStatus()
        }
    }
    
    // MARK: - Public Methods
    
    func checkAuthStatus() async {
        isLoading = true
        
        do {
            let session = try await localAuthService.getCurrentUser()
            currentUser = session?.toEntity()
            isAuthenticated = true
            print("✅ Usuario autenticado: \(session?.email ?? "")")
        } catch {
            isAuthenticated = false
            currentUser = nil
            print("ℹ️ No hay sesión activa")
        }
        
        isLoading = false
    }
    
    func completeOnboarding() {
        hasCompletedOnboarding = true
        userDefaults.set(true, forKey: onboardingKey)
        print("✅ Onboarding completado")
    }
    
    func login(user: Persona) {
        currentUser = user
        isAuthenticated = true
        print("✅ Usuario logueado: \(user.correo)")
    }
    
    func logout() {
        Task {
            do {
                try await localAuthService.signOut()
                currentUser = nil
                isAuthenticated = false
                print("✅ Sesión cerrada")
            } catch {
                print("❌ Error al cerrar sesión: \(error)")
            }
        }
    }
    
    func resetOnboarding() {
        hasCompletedOnboarding = false
        userDefaults.set(false, forKey: onboardingKey)
        logout()
        print("🔄 Onboarding reseteado")
    }
}
