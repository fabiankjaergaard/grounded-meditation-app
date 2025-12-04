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
    @State private var showTimer = false
    @State private var isPhasesExpanded = false

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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Constants.Colors.textPrimary)
                }
            }
        }
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

            Image("Timeovermeditations")
                .resizable()
                .scaledToFit()
                .frame(width: 350)
        }
        .frame(height: 200)
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
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                // Haptic feedback
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()

                withAnimation(.easeInOut(duration: 0.3)) {
                    isPhasesExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Fem faser")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Spacer()

                    Image(systemName: isPhasesExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Constants.Colors.textSecondary)
                }
                .padding(Constants.Spacing.standard)
            }
            .buttonStyle(PlainButtonStyle())

            if isPhasesExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    Divider()
                        .padding(.horizontal, Constants.Spacing.standard)

                    VStack(alignment: .leading, spacing: 16) {
                        PhaseRow(number: 1, duration: "10 min", title: "Kaotisk andning", description: "Andas kaotiskt genom näsan, koncentrera dig på utandningen")
                        PhaseRow(number: 2, duration: "10 min", title: "Catharsis", description: "Släpp lös! Låt kroppen göra vad den vill")
                        PhaseRow(number: 3, duration: "10 min", title: "Mantra", description: "Hoppa med armarna uppåt och ropa 'HOO!'")
                        PhaseRow(number: 4, duration: "15 min", title: "Stillhet", description: "Stanna kvar precis som du är, helt stilla")
                        PhaseRow(number: 5, duration: "15 min", title: "Celebration", description: "Dansa och fira livet!")
                    }
                    .padding(Constants.Spacing.standard)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Kundalini Instructions
    private var kundaliniInstructionsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                // Haptic feedback
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()

                withAnimation(.easeInOut(duration: 0.3)) {
                    isPhasesExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Fyra faser")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Spacer()

                    Image(systemName: isPhasesExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Constants.Colors.textSecondary)
                }
                .padding(Constants.Spacing.standard)
            }
            .buttonStyle(PlainButtonStyle())

            if isPhasesExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    Divider()
                        .padding(.horizontal, Constants.Spacing.standard)

                    VStack(alignment: .leading, spacing: 16) {
                        PhaseRow(number: 1, duration: "15 min", title: "Skakningar", description: "Stå och låt hela kroppen skaka, känn energin röra sig uppåt")
                        PhaseRow(number: 2, duration: "15 min", title: "Dans", description: "Dansa precis som du känner för")
                        PhaseRow(number: 3, duration: "15 min", title: "Stillhet", description: "Sitt eller stå stilla och observera")
                        PhaseRow(number: 4, duration: "15 min", title: "Ligg ner", description: "Lägg dig ner och var stilla")
                    }
                    .padding(Constants.Spacing.standard)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Start Button
    private var startButton: some View {
        Button(action: {
            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            showTimer = true
        }) {
            HStack {
                Image(systemName: "play.fill")
                Text("Start Meditation")
            }
            .font(Constants.Typography.bodyBold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Constants.Colors.primaryBlue)
            .cornerRadius(Constants.CornerRadius.button)
        }
        .fullScreenCover(isPresented: $showTimer) {
            MeditationTimerView(meditation: meditation) {
                showTimer = false
                dismiss()
            }
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
            // Number
            Text("\(number)")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Constants.Colors.textSecondary)
                .frame(width: 20)

            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Constants.Colors.textPrimary)

                    Spacer()

                    Text(duration)
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(Constants.Colors.textTertiary)
                }

                Text(description)
                    .font(.system(size: 14, weight: .regular))
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
