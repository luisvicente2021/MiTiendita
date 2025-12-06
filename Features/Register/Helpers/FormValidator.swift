//
//  FormValidator.swift
//  MiTiendita
//
//  Created by luisr on 19/11/25.
//
import UIKit
import Foundation

final class FormValidator {
    // MARK: - Validation Result
    struct ValidationResult {
        let isValid: Bool
        let errorMessage: String?
        
        static let valid = ValidationResult(isValid: true, errorMessage: nil)
        
        static func invalid(_ message: String) -> ValidationResult {
            ValidationResult(isValid: false, errorMessage: message)
        }
    }
    
    
    static func validateNombre(_ nombre: String) -> ValidationResult {
        let trimmed = nombre.trimmingCharacters(in: .whitespaces)
        
        guard !trimmed.isEmpty else {
            return .invalid("El nombre es obligatorio")
        }
        
        return .valid
    }
    
    static func validateTelefono(_ telefono: String) -> ValidationResult {
        guard !telefono.isEmpty else {
            return .invalid("El teléfono es obligatorio")
        }
        
        let cleaned = telefono.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard cleaned.count == 10 else {
            return .invalid("El teléfono debe tener 10 dígitos")
        }
        
        return .valid
    }
    
    static func validateEmail(_ email: String) -> ValidationResult {
        guard !email.isEmpty else {
            return .valid // Email es opcional
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            return .invalid("El correo no es válido")
        }
        
        return .valid
    }
    
    static func validateCreditLimit(_ limite: String) -> ValidationResult {
        guard !limite.isEmpty else {
            return .valid // Límite es opcional
        }
        
        guard let valor = Double(limite), valor >= 0 else {
            return .invalid("El límite debe ser un número válido")
        }
        
        return .valid
    }
    
    // MARK: - Formateo
    
    static func formatPhone(_ phone: String) -> String {
        let cleaned = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        return String(cleaned.prefix(10))
    }
    
    static func formatCreditLimit(_ limit: String) -> String {
        let filtered = limit.filter { "0123456789.".contains($0) }
        let components = filtered.components(separatedBy: ".")
        
        if components.count > 2 {
            return components[0] + "." + components[1]
        }
        
        return filtered
    }
}
