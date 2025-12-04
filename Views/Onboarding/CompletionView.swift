//
//  CompletionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct CompletionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    let onComplete: () -> Void

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient.welcomeGradient
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Check icon
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 120, height: 120)

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                }

                // Text content
                VStack(spacing: 16) {
                    Text("Du är redo!")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)

                    Text("Välkommen till Grounded, \(viewModel.userName)")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.9))

                    // Divider
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 60, height: 3)
                        .cornerRadius(1.5)

                    Text("Din personliga meditationsresa börjar nu")
                        .font(.system(size: 15))
                        .italic()
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, Constants.Spacing.standard)

                Spacer()

                // Start button
                Button(action: {
                    viewModel.completeOnboarding {
                        onComplete()
                    }
                }) {
                    Text("Börja meditera")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.primaryBlue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(Constants.CornerRadius.button)
                }
                .padding(Constants.Spacing.standard)
            }
        }
    }
}

#Preview {
    CompletionView(viewModel: OnboardingViewModel()) {
        print("Completed!")
    }
}
