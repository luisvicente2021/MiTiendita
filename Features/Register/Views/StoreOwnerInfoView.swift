//
//  StoreOwnerInfoView.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI

struct StoreOwnerInfoView: View {
    @EnvironmentObject private var viewModel: RegisterPersonViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    @FocusState private var focusedField: Field?
    
    enum Field {
        case ownerName, storeName, phone, email, pin
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            //headerSection
            
            ScrollView {
                VStack(spacing: 24) {
                    // Paso actual
                    Text("Paso 1 de 4")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 20)
                    
                    // Título
                    VStack(spacing: 8) {
                        Text("Información del Encargado")
                            .font(.title2.bold())
                        
                        Text("Completa los datos del responsable de la tienda")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    // Formulario
                    VStack(alignment: .leading, spacing: 16) {
                        CustomTextField(
                            icon: "person.fill",
                            placeholder: "Nombre completo *",
                            text: $viewModel.ownerName
                        )
                        .focused($focusedField, equals: .ownerName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .storeName }
                        
                        CustomTextField(
                            icon: "storefront.fill",
                            placeholder: "Nombre de la tienda *",
                            text: $viewModel.storeName
                        )
                        .focused($focusedField, equals: .storeName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .phone }
                        
                        CustomTextField(
                            icon: "phone.fill",
                            placeholder: "Teléfono *",
                            text: $viewModel.phone,
                            keyboard: .phonePad
                        )
                        .focused($focusedField, equals: .phone)
                        .onChange(of: viewModel.phone) { _, _ in
                            viewModel.formatPhone()
                        }
                        
                        CustomTextField(
                            icon: "envelope.fill",
                            placeholder: "Email (opcional)",
                            text: $viewModel.email,
                            keyboard: .emailAddress
                        )
                        .focused($focusedField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .pin }
                        
                        CustomTextField(
                            icon: "lock.fill",
                            placeholder: "PIN de 4 dígitos *",
                            text: $viewModel.password,
                            keyboard: .numberPad,
                            isSecure: true
                        )
                        .focused($focusedField, equals: .pin)
                        .onChange(of: viewModel.password) { _, _ in
                            viewModel.formatPin()
                        }
                        
                        Text("* Campos obligatorios")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 100)
                }
            }
            Button {
                coordinator.push(.camera)
            } label: {
                Label("Abrir cámara", systemImage: "camera")
            }
            Spacer()
            
            // Botones de navegación
            navigationButtons
        }
        
    }
    
    private var navigationButtons: some View {
        VStack(spacing: 12) {
            Button(action: {
                focusedField = nil
                withAnimation {
                    coordinator.push(.storeAddress)
                }
            }) {
                Text("Siguiente")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isStep1Valid ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .disabled(!viewModel.isStep1Valid)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}

#Preview {
    StoreOwnerInfoView()
}
