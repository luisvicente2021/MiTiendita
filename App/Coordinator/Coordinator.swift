//
//  Coordinator.swift
//  MiTiendita
//
//  Created by luisr on 26/11/25.
//
/*
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject  {
    @Published var flow: AppFlow = .onboarding

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
*/

// App/Coordinator/AppCoordinator.swift
// App/Coordinator/AppCoordinator.swift
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {
    // MARK: - Published Properties
    @Published var path = NavigationPath()
    @Published var sheet: AppSheet?
    @Published var fullScreenCover: AppFullScreenCover?
    
    // MARK: - App State
    let appState: AppState
    
    // MARK: - Initialization
    init(appState: AppState) {
        self.appState = appState
    }
    
    // MARK: - Navigation Methods
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func presentSheet(_ sheet: AppSheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func presentFullScreenCover(_ cover: AppFullScreenCover) {
        self.fullScreenCover = cover
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    // MARK: - Deep Links
    
    func handle(deepLink: URL) {
        // Manejar deep links
        print("🔗 Deep link recibido: \(deepLink)")
    }
    
    // MARK: - Helpers
    /**
     welcome
     case clientManagement
     case loanManagement
     case salesTracking
     case security
     
     */
    
    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        switch route {
        // Onboarding
        case .welcome:
            WelcomeView()
        case .clientManagement:
            ClientManagementView()
        case .loanManagement:
            LoanManagementView()
        case .salesTracking:
            SalesTrackingView()
        case .security:
            SecurityView()
            
        
        case .login:
            
            Text("Login")
        case .storeOwnerInfo:
            StoreOwnerInfoView()
        case .storeAddress:
            StoreAddressView()
        case .preferences:
            PreferencesView()
        case .summary:
            SummaryView()
        case .dashboard:
            DashboardView()
            
       
            
        }
    }
}

// MARK: - Sheet Types

enum AppSheet: Identifiable {
    case registrarCliente
    case registrarPago
    case settings
    
    var id: String {
        switch self {
        case .registrarCliente: return "registrarCliente"
        case .registrarPago: return "registrarPago"
        case .settings: return "settings"
        }
    }
}

// MARK: - FullScreenCover Types

enum AppFullScreenCover: Identifiable {
    case onboarding
    case login
    
    var id: String {
        switch self {
        case .onboarding: return "onboarding"
        case .login: return "login"
        }
    }
}
