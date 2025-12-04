//
//  FeaturesView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import Combine

struct FeaturesView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    let features = [
        Feature(
            icon: "heart.fill",
            title: "Guidande Meditationer",
            description: "Utforska olika meditationstekniker och stilar",
            gradient: [Color(hex: "#FF6B6B"), Color(hex: "#FF8E53")]
        ),
        Feature(
            icon: "message.circle.fill",
            title: "Dagliga Reflektioner",
            description: "Dokumentera dina insikter och din inre resa",
            gradient: [Color(hex: "#4FACFE"), Color(hex: "#00F2FE")]
        ),
        Feature(
            icon: "book.fill",
            title: "Spåra Din Framsteg",
            description: "Se din meditation streak och personliga utveckling",
            gradient: [Color(hex: "#43E97B"), Color(hex: "#38F9D7")]
        )
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Vad kan du göra i appen?")
                    .font(Constants.Typography.title)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text("Grounded hjälper dig fortsätta din meditationsresa")
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Constants.Spacing.standard)
            .padding(.top, 60)

            Spacer()

            // Feature cards
            VStack(spacing: Constants.Spacing.standard) {
                ForEach(features) { feature in
                    FeatureCard(feature: feature)
                }
            }
            .padding(Constants.Spacing.standard)

            Spacer()

            // Navigation buttons
            HStack(spacing: 12) {
                Button(action: {
                    viewModel.previousStep()
                }) {
                    Text("Tillbaka")
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(Constants.CornerRadius.button)
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.CornerRadius.button)
                                .stroke(Constants.Colors.borderDefault, lineWidth: 1)
                        )
                }

                Button(action: {
                    viewModel.nextStep()
                }) {
                    Text("Nästa")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Constants.Colors.primaryBlue)
                        .cornerRadius(Constants.CornerRadius.button)
                }
            }
            .padding(Constants.Spacing.standard)
        }
        .background(Constants.Colors.backgroundBeige)
    }
}

// MARK: - Feature Model
struct Feature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let gradient: [Color]
}

// MARK: - Feature Card
struct FeatureCard: View {
    let feature: Feature

    var body: some View {
        HStack(spacing: 16) {
            // Icon with gradient
            ZStack {
                LinearGradient(
                    colors: feature.gradient,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: 56, height: 56)
                .cornerRadius(12)

                Image(systemName: feature.icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(Constants.Typography.bodyBold)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text(feature.description)
                    .font(Constants.Typography.caption)
                    .foregroundColor(Constants.Colors.textSecondary)
                    .lineSpacing(2)
            }
        }
        .padding(Constants.Spacing.standard)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
        .shadow(
            color: Constants.Shadow.color,
            radius: Constants.Shadow.radius,
            x: Constants.Shadow.x,
            y: Constants.Shadow.y
        )
    }
}

#Preview {
    FeaturesView(viewModel: OnboardingViewModel())
}
