//
//  RootView.swift
//  MiTiendita
//
//  Created by luisr on 21/12/25.
//
import SwiftUI

struct RootView: View {
    @StateObject private var appState: AppState
    @StateObject private var coordinator: AppCoordinator
    @StateObject private var registerViewModel: RegisterPersonViewModel
    @StateObject private var onboardingViewModel: OnboardingViewModel
    
    private let dataSource: LocalAuthService
    private let registerPersonRepository: RegisterRepositoryImplementation
    private let registerPersonUseCase: RegisterUseCase
    
    init() {
        // Crear dependencias localmente (sin self)
        let appState = AppState()
        let dataSource = LocalAuthService()
        let repository = RegisterRepositoryImplementation(dataSource: dataSource)
        let useCase = RegisterUseCase(repository: repository)
        let viewModel = RegisterPersonViewModel(registerUseCase: useCase)
        let onboardingViewModel = OnboardingViewModel()
        
        // Inicializar StateObjects
        _appState = StateObject(wrappedValue: appState)
        _coordinator = StateObject(wrappedValue: AppCoordinator(appState: appState))
        _registerViewModel = StateObject(wrappedValue: viewModel)
        _onboardingViewModel = StateObject(wrappedValue: onboardingViewModel)
        
        // Asignar propiedades normales
        self.dataSource = dataSource
        self.registerPersonRepository = repository
        self.registerPersonUseCase = useCase
    }
    
    var body: some View {
        Group {
            if appState.isLoading {
                // Splash Screen
                LoadingView(message: "Cargando")
            } else {
                mainContent
            }
        }
        .environmentObject(appState)
        .environmentObject(coordinator)
        .environmentObject(onboardingViewModel)
        .environmentObject(registerViewModel)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if !appState.hasCompletedOnboarding {
            // Mostrar Onboarding
            onboardingFlow
           // mainAppFlow
        } else if !appState.isAuthenticated {
            // Mostrar Login
            // authFlow
            Text("quien sabe")
        } else {
            // Mostrar App principal
            mainAppFlow
        }
    }
    
    // MARK: - Onboarding Flow
    
    private var onboardingFlow: some View {
        NavigationStack(path: $coordinator.path) {
            WelcomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.view(for: route)
                }
        }
    }
    
    // MARK: - Auth Flow
    
    
    // MARK: - Main App Flow
    
    private var mainAppFlow: some View {
        NavigationStack(path: $coordinator.path) {
            DashboardView()
                .navigationDestination(for: AppRoute.self) { route in
                    coordinator.view(for: route)
                }
        }
        .sheet(item: $coordinator.sheet) { sheet in
            sheetView(for: sheet)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { cover in
            fullScreenCoverView(for: cover)
        }
    }
    
    // MARK: - Sheet Views
    
    @ViewBuilder
    private func sheetView(for sheet: AppSheet) -> some View {
        NavigationStack {
            switch sheet {
            case .registrarCliente:
                StoreOwnerInfoView()
                
                
            case .registrarPago:
                ClientesListView()
                //RegistrarPagoView()
            case .settings:
                ClientesListView() // SettingsView()
            }
        }
        .environmentObject(coordinator)
    }
    
    // MARK: - FullScreenCover Views
    
    @ViewBuilder
    private func fullScreenCoverView(for cover: AppFullScreenCover) -> some View {
        switch cover {
        case .onboarding:
            WelcomeView()
            
        case .login:
            ClientesListView()
            //LoginView()
        }
    }
}

#Preview {
    RootView()
}
