//
//  Coordinator.swift
//  MiTiendita
//
//  Created by luisr on 26/11/25.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject  {
    @Published var flow: AppFlow = .onboarding
    var persona: Persona?
    
    let loginRepository : LoginRepositoryImplementation
    let registerPersonRepository: RegisterRepositoryImplementation
    
    let loginUseCase: LoginUseCase
    let registerPersonUseCase: RegisterUseCase
    
    let loginViewModel: LoginViewModel
    let onboardingViewModel: OnboardingViewModel
    let registerViewModel: RegisterPersonViewModel
    
    let persistenceController: PersistenceController
    let dataSource: CustomerLocalDataSource
    
    
    init() {
        self.persistenceController = PersistenceController.shared
        self.dataSource = CustomerLocalDataSource()
        
        self.onboardingViewModel = OnboardingViewModel()
        
        self.loginRepository = LoginRepositoryImplementation(dataSource: dataSource)
        self.loginUseCase = LoginUseCase(repository: loginRepository)
        self.loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        
        self.registerPersonRepository = RegisterRepositoryImplementation(dataSource: dataSource)
        self.registerPersonUseCase = RegisterUseCase(repository: registerPersonRepository)
        self.registerViewModel = RegisterPersonViewModel(registerUseCase: registerPersonUseCase)
        
    }
}



extension AppCoordinator {
    @MainActor func didFinishOnboarding(persona: Persona) {
        self.persona = persona   // guardas temporalmente
        self.flow = .dashboard   // cambias el flujo
    }
}
