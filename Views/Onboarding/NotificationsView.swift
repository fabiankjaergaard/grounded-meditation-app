//
//  NotificationsView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct NotificationsView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedOption: NotificationOption = .yes

    enum NotificationOption {
        case yes
        case no
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Påminnelser")
                    .font(Constants.Typography.title)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text("Vill du få dagliga påminnelser att meditera?")
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Constants.Spacing.standard)
            .padding(.top, 60)

            Spacer()

            // Options
            VStack(spacing: 16) {
                NotificationOptionCard(
                    icon: Constants.Icons.bell,
                    title: "Ja tack",
                    description: "Få dagliga påminnelser om att meditera",
                    isSelected: selectedOption == .yes
                ) {
                    selectedOption = .yes
                    viewModel.notificationsEnabled = true
                }

                NotificationOptionCard(
                    icon: Constants.Icons.bell,
                    title: "Nej tack",
                    description: "Jag vill meditera på egen hand",
                    isSelected: selectedOption == .no
                ) {
                    selectedOption = .no
                    viewModel.notificationsEnabled = false
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

// MARK: - Notification Option Card
struct NotificationOptionCard: View {
    let icon: String
    let title: String
    let description: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(
                            isSelected
                            ? Constants.Colors.primaryBlue.opacity(0.1)
                            : Color.gray.opacity(0.05)
                        )
                        .frame(width: 56, height: 56)

                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(
                            isSelected
                            ? Constants.Colors.primaryBlue
                            : Constants.Colors.textTertiary
                        )
                }

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(description)
                        .font(Constants.Typography.caption)
                        .foregroundColor(Constants.Colors.textSecondary)
                        .lineSpacing(2)
                }

                Spacer()

                // Selection indicator
                ZStack {
                    Circle()
                        .stroke(
                            isSelected
                            ? Constants.Colors.primaryBlue
                            : Constants.Colors.borderDefault,
                            lineWidth: 2
                        )
                        .frame(width: 24, height: 24)

                    if isSelected {
                        Circle()
                            .fill(Constants.Colors.primaryBlue)
                            .frame(width: 14, height: 14)
                    }
                }
            }
            .padding(Constants.Spacing.standard)
            .background(
                isSelected
                ? Color(hex: "#E8F0F8")
                : Color.white
            )
            .cornerRadius(Constants.CornerRadius.card)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                    .stroke(
                        isSelected
                        ? Constants.Colors.primaryBlue
                        : Constants.Colors.borderDefault,
                        lineWidth: 2
                    )
            )
        }
    }
}

#Preview {
    NotificationsView(viewModel: OnboardingViewModel())
}
