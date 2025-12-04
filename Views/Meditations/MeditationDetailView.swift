//
//  MeditationDetailView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct MeditationDetailView: View {
    @Environment(\.dismiss) var dismiss
    let meditation: Meditation

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.Spacing.standard) {
                // Header image/icon
                headerSection

                // Title and duration
                titleSection

                // Description
                descriptionSection

                // Instructions
                if meditation.id == "dynamic" {
                    dynamicInstructionsSection
                } else if meditation.id == "kundalini" {
                    kundaliniInstructionsSection
                }

                // Start button
                startButton
            }
            .padding(Constants.Spacing.standard)
        }
        .background(Constants.Colors.backgroundBeige)
        .navigationTitle(meditation.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Header Section
    private var headerSection: some View {
        ZStack {
            Image("Blue-background")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(Constants.CornerRadius.card)

            Image(systemName: meditation.id == "dynamic" ? "bolt.fill" : "sparkles")
                .font(.system(size: 72))
                .foregroundColor(.white.opacity(0.9))
        }
    }

    // MARK: - Title Section
    private var titleSection: some View {
        VStack(spacing: 8) {
            Text(meditation.title)
                .font(Constants.Typography.title)
                .foregroundColor(Constants.Colors.textPrimary)

            HStack(spacing: 16) {
                Label(meditation.duration, systemImage: Constants.Icons.clock)
                Label(meditation.category.rawValue, systemImage: "tag.fill")
            }
            .font(Constants.Typography.subheadline)
            .foregroundColor(Constants.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Description Section
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Om meditationen")
                .font(Constants.Typography.bodyBold)
                .foregroundColor(Constants.Colors.textPrimary)

            Text(meditation.description)
                .font(Constants.Typography.body)
                .foregroundColor(Constants.Colors.textSecondary)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Dynamic Instructions
    private var dynamicInstructionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Fem faser")
                .font(Constants.Typography.bodyBold)
                .foregroundColor(Constants.Colors.textPrimary)

            VStack(alignment: .leading, spacing: 12) {
                PhaseRow(number: 1, duration: "10 min", title: "Kaotisk andning", description: "Andas kaotiskt genom näsan, koncentrera dig på utandningen")
                PhaseRow(number: 2, duration: "10 min", title: "Catharsis", description: "Släpp lös! Låt kroppen göra vad den vill")
                PhaseRow(number: 3, duration: "10 min", title: "Mantra", description: "Hoppa med armarna uppåt och ropa 'HOO!'")
                PhaseRow(number: 4, duration: "15 min", title: "Stillhet", description: "Stanna kvar precis som du är, helt stilla")
                PhaseRow(number: 5, duration: "15 min", title: "Celebration", description: "Dansa och fira livet!")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Kundalini Instructions
    private var kundaliniInstructionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Fyra faser")
                .font(Constants.Typography.bodyBold)
                .foregroundColor(Constants.Colors.textPrimary)

            VStack(alignment: .leading, spacing: 12) {
                PhaseRow(number: 1, duration: "15 min", title: "Skakningar", description: "Stå och låt hela kroppen skaka, känn energin röra sig uppåt")
                PhaseRow(number: 2, duration: "15 min", title: "Dans", description: "Dansa precis som du känner för")
                PhaseRow(number: 3, duration: "15 min", title: "Stillhet", description: "Sitt eller stå stilla och observera")
                PhaseRow(number: 4, duration: "15 min", title: "Ligg ner", description: "Lägg dig ner och var stilla")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Start Button
    private var startButton: some View {
        Button(action: {
            // TODO: Start meditation timer/audio
            print("Start meditation: \(meditation.id)")
        }) {
            HStack {
                Image(systemName: "play.fill")
                Text("Starta meditation")
            }
            .font(Constants.Typography.bodyBold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Constants.Colors.primaryBlue)
            .cornerRadius(Constants.CornerRadius.button)
        }
    }
}

// MARK: - Phase Row
struct PhaseRow: View {
    let number: Int
    let duration: String
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Number circle
            ZStack {
                Circle()
                    .fill(Constants.Colors.primaryBlue.opacity(0.1))
                    .frame(width: 32, height: 32)

                Text("\(number)")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Constants.Colors.primaryBlue)
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(Constants.Typography.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Spacer()

                    Text(duration)
                        .font(Constants.Typography.caption)
                        .foregroundColor(Constants.Colors.textTertiary)
                }

                Text(description)
                    .font(Constants.Typography.caption)
                    .foregroundColor(Constants.Colors.textSecondary)
                    .lineSpacing(2)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MeditationDetailView(meditation: .dynamicMeditation)
    }
}
