//
//  OnboardingRepositoryProtocol.swift
//  MiTiendita
//
//  Created by luisr on 26/11/25.
//

import Foundation

protocol OnboardingRepository {
    func hasCompleteOnboarding() -> Bool
    func skipOnboarding() -> Bool
}
