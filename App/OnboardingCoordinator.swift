//
//  OmboardingView.swift
//  MiTiendita
//
//  Created by luisr on 20/11/25.
//

import SwiftUI

class OnboardingCoordinator: ObservableObject {
    
    @Published var currentScreen: OnboardingScreen = .welcome
    weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor func finishOnboarding(with persona: Persona) {
        appCoordinator?.didFinishOnboarding(persona: persona)
    }
}
