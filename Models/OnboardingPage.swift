//
//  OnboardingPage.swift
//  MiTiendita
//
//  Created by luisr on 26/11/25.
//

import Foundation
import SwiftUI

struct OnboardingPage: Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let imageName: String
    let color: Color
    let order: Int
    
    init(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        imageName: String,
        color: Color,
        order: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imageName = imageName
        self.color = color
        self.order = order
    }
}
