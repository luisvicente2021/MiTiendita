//
//  FeatureBadge.swift
//  MiTiendita
//
//  Created by luisr on 25/11/25.
//

import SwiftUI

struct FeatureBadge: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.green)
                .font(.title3)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}
