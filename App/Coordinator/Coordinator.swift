//
//  Coordinator.swift
//  MiTiendita
//
//  Created by luisr on 26/11/25.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject  {
    @Published var flow: AppFlow = .dashboard
    var persona: Persona?
    
    let loginRepository : LoginRepositoryImplementation
    let registerPersonRepository: RegisterRepositoryImplementation
    
    let loginUseCase: LoginUseCase
    let getClientesUseCase: GetClientesUseCase
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
        self.getClientesUseCase = GetClientesUseCase(repository: loginRepository)
        self.loginViewModel = LoginViewModel(getClientesUseCase: getClientesUseCase, loginUseCase: loginUseCase)
        
        self.registerPersonRepository = RegisterRepositoryImplementation(dataSource: dataSource)
        self.registerPersonUseCase = RegisterUseCase(repository: registerPersonRepository)
        self.registerViewModel = RegisterPersonViewModel(registerUseCase: registerPersonUseCase)
        
    }
}



extension AppCoordinator {
    @MainActor func didFinishOnboarding() {
        self.flow = .register   // cambias el flujo
    }
}
