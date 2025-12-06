//
//  RegistrarPersonaViewModel.swift
//  MiTiendita
//
//  Created by luisr on 18/11/25.
//
import SwiftUI
import Foundation

@MainActor
final class RegisterPersonViewModel: ObservableObject {
    @Published var ownerName = ""
    @Published var storeName = ""
    
    @Published var street = ""
    @Published var neighborhood = ""
    @Published var city = ""
    @Published var postalCode = ""
    
    @Published var cloudBackup = true
    @Published var requirePin = false
    @Published var maxFiado: Double = 1000

    @Published var email = ""
    @Published var phone = ""
    @Published var password = ""
    @Published var photoData: Data? = nil
    @Published var persona: Persona? = nil
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showSuccessAlert = false
    @Published var onboardingCompleted = false
    
    var canProceedFromWelcome: Bool {
        !ownerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !storeName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var canProceedFromAddress: Bool {
        !street.isEmpty &&
        !city.isEmpty
    }
    
    var canRegister: Bool {
        !email.isEmpty &&
        !phone.isEmpty &&
        !password.isEmpty &&
        password.count >= 6 &&
        !isLoading
    }
    
    var isStep1Valid: Bool {
        !ownerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !storeName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !phone.isEmpty &&
        password.count == 6 &&
        isValidPhone(phone) &&
        (email.isEmpty || isValidEmail(email))
    }
    
    var isStep2Valid: Bool {
        !street.isEmpty &&
        !neighborhood.isEmpty &&
        !city.isEmpty &&
        !postalCode.isEmpty &&
        postalCode.count == 5
    }
    
    func formatPhone() {
        phone = FormValidator.formatPhone(phone)
    }
    
    func formatPostalCode() {
        postalCode = String(postalCode.filter { $0.isNumber }.prefix(5))
    }
    
    func formatPin() {
        password = String(password.filter { $0.isNumber }.prefix(6))
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        let cleaned = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return cleaned.count == 10
    }
    
    private let registerUseCase: RegisterUseCase
    
    init(registerUseCase: RegisterUseCase) {
        self.registerUseCase = registerUseCase
    }

    func register(nuevaPersona: Persona) async {
        guard canRegister else {
            errorMessage = "Por favor completa todos los campos correctamente"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Obtener el contexto desde tu datasource
        let context = PersistenceController.shared.context
        self.persona = persona
        
        
        do {
            try context.save()
            registerUseCase.registerPerson(person: nuevaPersona)
            print("✅ Usuario registrado exitosamente")
            
            // 2. Mostrar alerta de éxito
            isLoading = false
            showSuccessAlert = true
            
        } catch {
            isLoading = false
            handleRegistrationError(error)
        }
    }
    
    func clearForm() {
        ownerName = ""
        storeName = ""
        street = ""
        neighborhood = ""
        city = ""
        postalCode = ""
        email = ""
        phone = ""
        password = ""
        cloudBackup = true
        requirePin = false
        maxFiado = 1000
        errorMessage = nil
    }
    
    // MARK: - Private Methods
    
    private func handleRegistrationError(_ error: Error) {
        if error.localizedDescription.contains("already registered") {
            errorMessage = "Este correo ya está registrado"
        } else if error.localizedDescription.contains("invalid email") {
            errorMessage = "El correo electrónico no es válido"
        } else if error.localizedDescription.contains("weak password") {
            errorMessage = "La contraseña es muy débil"
        } else if error.localizedDescription.contains("network") {
            errorMessage = "Sin conexión a internet"
        } else {
            errorMessage = "Error al registrar usuario. Intenta de nuevo."
        }
        
        print("❌ Error en registro: \(error.localizedDescription)")
    }
}

