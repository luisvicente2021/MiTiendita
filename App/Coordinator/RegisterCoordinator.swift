//
//  RegisterCoordinator.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//

import SwiftUI

class RegisterCoordinator: ObservableObject {
    
    @Published var currentScreen: RegisterScreen = .storeOwnerInfo
    var nuevaPersona: Persona?
    weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor func finishOnboarding(nuevaPersona: Persona) {
        self.nuevaPersona = nuevaPersona
        appCoordinator?.flow = .dashboard
    }
}

