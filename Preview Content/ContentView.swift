//
//  ContentView.swift
//  MiTiendita
//
//  Created by luisr on 12/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack {
            
            switch coordinator.flow {
            case .onboarding:
                OnboardingCoordinatorView(coordinator: OnboardingCoordinator(appCoordinator: coordinator))
                
            case .register:
                OnboardingCoordinatorView(coordinator: OnboardingCoordinator(appCoordinator: coordinator))
                
            case .auth:
                OnboardingCoordinatorView(coordinator: OnboardingCoordinator(appCoordinator: coordinator))
                
            case .dashboard:
                DashboardCoordinatorView(coordinator: DashboardCoordinator(appCoordinator: coordinator))
            }
        }
        .environmentObject(coordinator.onboardingViewModel)
        .environmentObject(coordinator.registerViewModel)
        .environmentObject(coordinator.loginViewModel)
        
    }
}
