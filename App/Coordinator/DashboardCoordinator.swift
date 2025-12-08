//
//  DashboardCoordinator.swift
//  MiTiendita
//
//  Created by luisr on 06/12/25.
//

import SwiftUI

class DashboardCoordinator: ObservableObject {
    
    @Published var currentScreen: DashboardScreen = .dashboard
    weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }
    
    @MainActor func finishOnboarding() {
        appCoordinator?.flow = .auth
    }
}
