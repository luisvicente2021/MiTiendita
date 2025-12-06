//
//  StoreAddressView.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI


struct StoreAddressView: View {
    @EnvironmentObject private var viewModel: RegisterPersonViewModel
    let onNext: () -> Void
    let onBack: () -> Void
    @FocusState private var focusedField: Field?
    
    enum Field {
        case street, neighborhood, city, postalCode
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            headerSection
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Paso 2 de 4")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 20)
                    
                    VStack(spacing: 8) {
                        Text("Dirección de la Tienda")
                            .font(.title2.bold())
                        
                        Text("Ingresa la ubicación de tu negocio")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        CustomTextField(
                            icon: "map.fill",
                            placeholder: "Calle y número *",
                            text: $viewModel.street
                        )
                        .focused($focusedField, equals: .street)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .neighborhood }
                        
                        CustomTextField(
                            icon: "building.2.fill",
                            placeholder: "Colonia *",
                            text: $viewModel.neighborhood
                        )
                        .focused($focusedField, equals: .neighborhood)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .city }
                        
                        CustomTextField(
                            icon: "location.fill",
                            placeholder: "Ciudad *",
                            text: $viewModel.city
                        )
                        .focused($focusedField, equals: .city)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .postalCode }
                        
                        CustomTextField(
                            icon: "signpost.right.fill",
                            placeholder: "Código Postal *",
                            text: $viewModel.postalCode,
                            keyboard: .numberPad
                        )
                        .focused($focusedField, equals: .postalCode)
                        .onChange(of: viewModel.postalCode) { _, _ in
                            viewModel.formatPostalCode()
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 100)
                }
            }
            
            // Botones de navegación
            navigationButtons
        }
        .navigationBarHidden(true)
    }
    
    private var headerSection: some View {
        HStack {
            Button(action: {
            }) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text("2/4")
                .font(.subheadline.bold())
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 12) {
            Button(action: {
                withAnimation {
                    onBack()
                }
            }) {
                Text("Atrás")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
            }
            
            Button(action: {
                focusedField = nil
                onNext()
                
            }) {
                Text("Siguiente")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isStep2Valid ? Color.blue : Color.gray)
                    .cornerRadius(12)
            }
            .disabled(!viewModel.isStep2Valid)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 30)
        .background(Color(.systemBackground))
    }
}


#Preview {
    // StoreAddressView()
}
