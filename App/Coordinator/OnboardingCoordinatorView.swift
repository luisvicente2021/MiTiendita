//
//  OnboardingCoordinatorView.swift
//  MiTiendita
//
//  Created by luisr on 03/12/25.
//
import SwiftUI

struct OnboardingCoordinatorView: View {
    @ObservedObject var coordinator: OnboardingCoordinator
    
    var body: some View {
        switch coordinator.currentScreen {
        case .welcome:
            WelcomeView(onNext: {
                coordinator.currentScreen = .clientManagement
            })
            
        case .clientManagement:
            ClientManagementView {
                coordinator.currentScreen = .loanManagement
            } onBack: {
                coordinator.currentScreen = .welcome
            }
            
        case .loanManagement:
            LoanManagementView {
                coordinator.currentScreen = .salesTracking
            } onBack: {
                coordinator.currentScreen = .clientManagement
            }
            
        case .salesTracking:
            SalesTrackingView {
                coordinator.currentScreen = .security
            } onBack: {
                coordinator.currentScreen = .loanManagement
            }
            
        case .security:
            SecurityView {
                coordinator.finishOnboarding()
                print("Termino el flujo de onboarding")
            } onBack: {
                coordinator.currentScreen = .salesTracking
            }
        }
    }
}
