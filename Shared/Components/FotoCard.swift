//
//  FotoCard.swift
//  MiTiendita
//
//  Created by luisr on 18/11/25.
//
import SwiftUI


struct FotoCard: View {
    var titulo: String
    @Binding var imagen: UIImage?
    @Binding var mostrarCamara: Bool
    var icono: String
    
    var body: some View {
        VStack(spacing: 10) {
            if let img = imagen {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            } else {
                Image(systemName: icono)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.vertical)
            }
            
            Button {
                mostrarCamara = true
            } label: {
                Label("Tomar \(titulo)", systemImage: "camera.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
