
import Foundation
import SwiftUI

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var ownerName = ""
    @Published var storeName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var pin = ""
    @Published var street = ""
    @Published var neighborhood = ""
    @Published var city = ""
    @Published var postalCode = ""
    @Published var cloudBackup = true
    @Published var requirePin = true
    @Published var maxFiado: Double = 1000
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showSuccessAlert = false
    @Published var registrationSuccess = false
    @Published var currentStep: OnboardingStep = .welcome
    @Published var shouldShowOnboarding: Bool = false
    
    init() {
        loanOnboardingState()
        
    }
    
    enum OnboardingStep {
        case welcome        // Pantalla 1: Bienvenida
        case features       // Pantalla 2: Características
        case register       // Pantalla 3: Registro
    }
    
    let totalSteps = 3
    
    var currentStepIndex: Int {
        switch currentStep {
        case .welcome: return 0
        case .features: return 1
        case .register: return 2
        }
    }
    
    var progressPercentage: Double {
        Double(currentStepIndex + 1) / Double(totalSteps)
    }
    
    func nextStep() {
        switch currentStep {
        case .welcome:
            currentStep = .features
        case .features:
            currentStep = .register
        case .register:
            break // Se completa cuando el usuario se registra exitosamente
        }
    }
    
    func previousStep() {
        switch currentStep {
        case .welcome:
            break
        case .features:
            currentStep = .welcome
        case .register:
            currentStep = .features
        }
    }
    
    func loanOnboardingState() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        shouldShowOnboarding = hasSeenOnboarding
        
        print("No se ha visto  el Onboarding valor de hasseen \(shouldShowOnboarding)")
    }
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        shouldShowOnboarding = false
        
        print("Se vio el Onboarding valor de hasseen \(shouldShowOnboarding)")
    }
}
