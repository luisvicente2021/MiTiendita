//
//  NavigationButtons.swift
//  MiTiendita
//
//  Created by luisr on 01/12/25.
//
import SwiftUI


struct NavigationButtons: View {
    let onBack: (() -> Void)?
    let onNext: (() -> Void)?

    var body: some View {
        HStack(spacing: 16) {
            if let onBack = onBack {
                Button("Atrás") {
                    onBack()
                }
                .buttonStyleBackground(isPrimary: false)
            }

            Button("Siguiente") {
                onNext?()
            }
            .buttonStyleBackground()
        }
        .padding()
    }
}

extension View {
    func buttonStyleBackground(isPrimary: Bool = true) -> some View {
        self
            .font(.headline)
            .foregroundColor(isPrimary ? .white : .secondary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                isPrimary ?
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing) :
                    LinearGradient(colors: [Color(.systemGray6), Color(.systemGray6)], startPoint: .leading, endPoint: .trailing)
                
            )
            .cornerRadius(16)
    }
}


/*
struct NavigationButtons: View {
    @Binding var currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                withAnimation {
                    currentPage -= 1
                }
            }) {
                Text("Atrás")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(16)
            }
            
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    currentPage += 1
                }
            }) {
                Text("Siguiente")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(16)
            }
        }
    }
}
*/
