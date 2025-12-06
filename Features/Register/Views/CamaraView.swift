//
//  ContentView.swift
//  MiTiendita
//
//  Created by luisr on 05/12/25.
//


import SwiftUI

struct CamaraView: View {
    @State private var showingCamera = false
    @State private var image: UIImage? = nil
    @EnvironmentObject private var viewModel: RegisterPersonViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Si hay foto, la muestra. Si no, usa una por defecto.
            Image(uiImage: image ?? UIImage(named: "vanilla")!)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
            
            Button("Tomar foto") {
#if targetEnvironment(simulator)
                // En simulador, carga una imagen por defecto
                image = UIImage(named: "vanilla")
                
                if let img = image,
                   let data = img.jpegData(compressionQuality: 0.8) {
                    viewModel.photoData = data       // guardas la foto
                }
#else
                // En dispositivo real, abre la cámara
                showingCamera = true
#endif
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .sheet(isPresented: $showingCamera) {
            ImagePicker(sourceType: .camera, selectedImage: $image)
        }
        .onChange(of: image) { image in
            if let img = image,
               let data = img.jpegData(compressionQuality: 0.8) {
                viewModel.photoData = data
            }
        }
    }
}
