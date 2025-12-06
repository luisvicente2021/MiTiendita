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
                coordinator.currentScreen = .storeOwnerInfo
            } onBack: {
                coordinator.currentScreen = .salesTracking
            }
            
        case .storeOwnerInfo:
            StoreOwnerInfoView {
                coordinator.currentScreen = .storeAddress
            }
            
        case .storeAddress:
            StoreAddressView {
                coordinator.currentScreen = .preferences
            } onBack: {
                coordinator.currentScreen = .storeOwnerInfo
            }
            
        case .preferences:
            PreferencesView {
                coordinator.currentScreen = .summary
            } onBack: {
                coordinator.currentScreen = .storeAddress
            }
            
        case .summary:
            SummaryView {
                print("Termno onboarding y register")
            } onFinish: { nuevapersona in
                coordinator.finishOnboarding(with: nuevapersona)
            }
        }
    }
}
