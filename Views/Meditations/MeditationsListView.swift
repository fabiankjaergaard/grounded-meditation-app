//
//  MeditationsListView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct MeditationsListView: View {
    @State private var selectedCategory: Meditation.MeditationCategory = .alla
    let meditations = Meditation.allMeditations

    var filteredMeditations: [Meditation] {
        if selectedCategory == .alla {
            return meditations
        }
        return meditations.filter { $0.category == selectedCategory }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.standard) {
                    // Header
                    headerSection

                    // Category filter
                    categoryFilter

                    // Meditation cards
                    ForEach(filteredMeditations) { meditation in
                        if meditation.isAvailable {
                            NavigationLink(destination: MeditationDetailView(meditation: meditation)) {
                                MeditationCard(meditation: meditation) {
                                    // Navigation handled by NavigationLink
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        } else {
                            MeditationCard(meditation: meditation) {
                                // Disabled, do nothing
                            }
                        }
                    }
                }
                .padding(Constants.Spacing.standard)
            }
            .background(Constants.Colors.backgroundBeige)
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("Meditationer")
                .font(Constants.Typography.largeTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Välj din meditation för dagen")
                .font(Constants.Typography.body)
                .foregroundColor(.white.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(Constants.Spacing.standard)
        .background(
            Image("Blue-background")
                .resizable()
                .scaledToFill()
        )
        .cornerRadius(Constants.CornerRadius.card)
        .clipped()
    }

    // MARK: - Category Filter
    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Meditation.MeditationCategory.allCases, id: \.self) { category in
                    CategoryChip(
                        title: category.rawValue,
                        isSelected: selectedCategory == category
                    ) {
                        selectedCategory = category
                    }
                }
            }
        }
    }

    // MARK: - Actions
    private func handleMeditationTap(_ meditation: Meditation) {
        if meditation.isAvailable {
            print("Navigate to: \(meditation.title)")
            // TODO: Navigate to meditation detail
        }
    }
}

// MARK: - Category Chip
struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(Constants.Typography.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : Constants.Colors.textPrimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    isSelected ? Constants.Colors.primaryBlue : Color.white
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            isSelected ? Color.clear : Constants.Colors.borderDefault,
                            lineWidth: 1
                        )
                )
        }
    }
}

// MARK: - Meditation Card
struct MeditationCard: View {
    let meditation: Meditation
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Play button
                ZStack {
                    Circle()
                        .fill(
                            meditation.isAvailable
                            ? Constants.Colors.primaryBlue.opacity(0.1)
                            : Color.gray.opacity(0.1)
                        )
                        .frame(width: 56, height: 56)

                    Image(systemName: Constants.Icons.play)
                        .font(.system(size: 24))
                        .foregroundColor(
                            meditation.isAvailable
                            ? Constants.Colors.primaryBlue
                            : .gray
                        )
                }

                // Content
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(meditation.title)
                            .font(Constants.Typography.bodyBold)
                            .foregroundColor(Constants.Colors.textPrimary)

                        if !meditation.isAvailable {
                            Text("SNART")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(Constants.Colors.textTertiary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(4)
                        }
                    }

                    HStack(spacing: 4) {
                        Image(systemName: Constants.Icons.clock)
                            .font(.system(size: 12))
                        Text(meditation.duration)
                            .font(Constants.Typography.caption)
                    }
                    .foregroundColor(Constants.Colors.textSecondary)

                    Text(meditation.description)
                        .font(Constants.Typography.caption)
                        .foregroundColor(Constants.Colors.textSecondary)
                        .lineLimit(2)
                }

                Spacer()
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.card)
            .shadow(
                color: Constants.Shadow.color,
                radius: Constants.Shadow.radius,
                x: Constants.Shadow.x,
                y: Constants.Shadow.y
            )
            .opacity(meditation.isAvailable ? 1.0 : 0.5)
        }
        .disabled(!meditation.isAvailable)
    }
}

#Preview {
    MeditationsListView()
}
