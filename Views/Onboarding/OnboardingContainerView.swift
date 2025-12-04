//
//  OnboardingContainerView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    let onComplete: () -> Void

    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()

            switch viewModel.currentStep {
            case 0:
                WelcomeView(viewModel: viewModel)
            case 1:
                FeaturesView(viewModel: viewModel)
            case 2:
                ProfileSetupView(viewModel: viewModel)
            case 3:
                NotificationsView(viewModel: viewModel)
            case 4:
                CompletionView(viewModel: viewModel, onComplete: onComplete)
            default:
                WelcomeView(viewModel: viewModel)
            }
        }
        .animation(.easeInOut, value: viewModel.currentStep)
    }
}

#Preview {
    OnboardingContainerView {
        print("Onboarding completed!")
    }
}
