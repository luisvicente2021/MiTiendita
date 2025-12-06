//
//  SectionCard.swift
//  MiTiendita
//
//  Created by luisr on 18/11/25.
//

import SwiftUI

struct SectionCard<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}
