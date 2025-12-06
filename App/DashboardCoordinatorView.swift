//
//  OnboardingCoordinatorView 2.swift
//  MiTiendita
//
//  Created by luisr on 04/12/25.
//


import SwiftUI

struct DashboardCoordinatorView: View {
    @ObservedObject var coordinator: DashboardCoordinator
    
    var body: some View {
        switch coordinator.currentScreen {
        case .dashboard:
            DashboardView()
            
        }
    }
}
