//
//  ComidaView.swift
//  MiTiendita
//
//  Created by luisr on 07/12/25.
//
import SwiftUI

struct ComidaView: View {
    var body: some View {
        VStack {
            Text("Registrar Comida fiada (próximamente)")
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
