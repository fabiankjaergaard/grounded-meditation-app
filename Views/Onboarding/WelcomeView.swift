//
//  WelcomeView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient.welcomeGradient
                .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Icon
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 100, height: 100)

                    Image(systemName: "sparkles")
                        .font(.system(size: 48))
                        .foregroundColor(.white)
                }

                // Text content
                VStack(spacing: 16) {
                    Text("Välkommen till")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.9))

                    Text("Grounded")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)

                    // Divider
                    Rectangle()
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 60, height: 3)
                        .cornerRadius(1.5)

                    Text("Din personliga meditationsapp")
                        .font(.system(size: 18))
                        .foregroundColor(.white.opacity(0.9))

                    Text("Inspirerad av Baravara retreat center")
                        .font(.system(size: 14))
                        .italic()
                        .foregroundColor(.white.opacity(0.7))
                }

                Spacer()

                // Continue button
                Button(action: {
                    viewModel.nextStep()
                }) {
                    HStack {
                        Text("Kom igång")
                            .font(Constants.Typography.bodyBold)
                        Image(systemName: Constants.Icons.chevronRight)
                    }
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
    WelcomeView(viewModel: OnboardingViewModel())
}
