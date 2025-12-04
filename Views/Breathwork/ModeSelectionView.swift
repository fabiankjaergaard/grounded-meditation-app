//
//  ModeSelectionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct ModeSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let patternKey: String
    let onSelectMode: (BreathworkMode) -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.standard) {
                Spacer()

                // Title
                VStack(spacing: 8) {
                    Text(Strings.ModeSelection.title)
                        .font(Constants.Typography.title)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(Strings.ModeSelection.subtitle)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()
                    .frame(height: 40)

                // Mode options
                VStack(spacing: 16) {
                    ModeOptionCard(
                        icon: "video.fill",
                        title: Strings.ModeSelection.videoTitle,
                        description: Strings.ModeSelection.videoDescription
                    ) {
                        onSelectMode(.video)
                    }

                    ModeOptionCard(
                        icon: "hand.raised.fill",
                        title: Strings.ModeSelection.interactiveTitle,
                        description: Strings.ModeSelection.interactiveDescription
                    ) {
                        onSelectMode(.interactive)
                    }
                }

                Spacer()
            }
            .padding(Constants.Spacing.standard)
            .background(
                Image("Card-background-meditation")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
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
    }
}

// MARK: - Mode Option Card
struct ModeOptionCard: View {
    let icon: String
    let title: String
    let description: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 20) {
                // Icon
                ZStack {
                    Circle()
                        .fill(Constants.Colors.primaryBlue.opacity(0.1))
                        .frame(width: 64, height: 64)

                    Image(systemName: icon)
                        .font(.system(size: 28))
                        .foregroundColor(Constants.Colors.primaryBlue)
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(description)
                        .font(Constants.Typography.subheadline)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()

                Image(systemName: Constants.Icons.chevronRight)
                    .foregroundColor(Constants.Colors.textTertiary)
            }
            .padding(Constants.Spacing.standard)
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
}

enum BreathworkMode {
    case video
    case interactive
}

#Preview {
    ModeSelectionView(patternKey: "morning") { mode in
        print("Selected: \(mode)")
    }
}
