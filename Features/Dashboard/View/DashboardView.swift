//
//  DashboardView.swift
//  MiTiendita
//
//  Created by luisr on 12/08/25.
//

import SwiftUI

struct DashboardView: View {
    //@EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        
        TabView {
            
            ClientesListView()
                .navigationTitle("Fiadores")
                .navigationBarTitleDisplayMode(.inline)
                .tabItem {
                    Image(systemName: "banknote.fill")
                    Text("Fiados")
                    
                }
            
            
            ModaView()
                .tabItem {
                    Image(systemName: "tshirt.fill")
                    Text("Moda")
                }
            
            ComidaView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Comida")
                }
        }
        
    }
}
