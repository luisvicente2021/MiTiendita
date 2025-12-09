//
//  RegisterCoordinatorView.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//
import SwiftUI

struct RegisterCoordinatorView: View {
    @ObservedObject var coordinator: RegisterCoordinator
    
    var body: some View {
        switch coordinator.currentScreen {
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
                print("Termino register")
            } onFinish: { nuevapersona in
                coordinator.finishOnboarding(nuevaPersona: nuevapersona)
            }
        }
    }
}
