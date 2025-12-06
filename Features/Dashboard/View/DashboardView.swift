//
//  DashboardView.swift
//  MiTiendita
//
//  Created by luisr on 12/08/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        TabView {
            
            ClientesListView()
                .navigationTitle("Fiadores")
                .navigationBarTitleDisplayMode(.inline)
                .tabItem {
                    Image(systemName: "banknote.fill")
                    Text("Fiados")
                    
                }
            
            // PersonaFormView()
                .tabItem {
                    Image(systemName: "person.badge.plus")
                    Text("Agregar Cliente")
                }
            
            PagosView()
                .tabItem {
                    Image(systemName: "tshirt.fill")
                    Text("Moda")
                }
            
            HistorialView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Comida")
                }
        }
        
    }
}


struct PersonasView: View {
    var body: some View {
        VStack {
            //   NavigationLink("Registrar Persona", destination: PersonaFormView())
            // .padding()
        }
        .navigationTitle("Personas")
        
    }
}


struct VentasView: View {
    var body: some View {
        Text("Registrar venta fiada (próximamente)")
    }
}

struct PagosView: View {
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(.blue)
                
                Rectangle()
                    .fill(.orange)
                
                Rectangle()
                    .fill(.yellow)
                
            }
            HStack {
                Rectangle()
                    .fill(.orange)
                    .frame(width: 400, height: 100)
                
            }
            HStack {
                Circle()
                    .fill(.green)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 80, height: 200)
                
                Circle()
                    .fill(.blue)
            }
            HStack {
                Rectangle()
                    .fill(.orange)
                    .frame(width: 400, height: 200)
                
            }
            HStack {
                Rectangle()
                    .fill(.blue)
                Rectangle()
                    .fill(.orange)
                Rectangle()
                    .fill(.yellow)
                
                
            }
            
            
        }
        .background(.red)
        
    }
}

struct HistorialView: View {
    var body: some View {
        Text("Historial de movimientos (próximamente)")
    }
}



#Preview {
}
