//
//  DurationSelectionView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct DurationSelectionView: View {
    @Environment(\.dismiss) var dismiss
    let onSelectDuration: (Int) -> Void

    let durations = [5, 10, 15, 20]

    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.Spacing.standard) {
                Spacer()

                // Title
                VStack(spacing: 8) {
                    Text("Välj längd")
                        .font(Constants.Typography.title)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text("Hur länge vill du meditera?")
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                }

                Spacer()
                    .frame(height: 40)

                // Duration options
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(durations, id: \.self) { duration in
                        DurationCard(duration: duration) {
                            onSelectDuration(duration)
                        }
                    }
                }

                Spacer()
            }
            .padding(Constants.Spacing.standard)
            .background(Constants.Colors.backgroundBeige)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Constants.Colors.textPrimary)
                    }
                }
            }
        }
    }
}

// MARK: - Duration Card
struct DurationCard: View {
    let duration: Int
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Clock icon
                ZStack {
                    Circle()
                        .fill(Constants.Colors.primaryBlue.opacity(0.1))
                        .frame(width: 64, height: 64)

                    Image(systemName: Constants.Icons.clock)
                        .font(.system(size: 28))
                        .foregroundColor(Constants.Colors.primaryBlue)
                }

                // Duration text
                VStack(spacing: 4) {
                    Text("\(duration)")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text("minuter")
                        .font(Constants.Typography.subheadline)
                        .foregroundColor(Constants.Colors.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Constants.Spacing.standard)
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

#Preview {
    DurationSelectionView { duration in
        print("Selected: \(duration) minutes")
    }
}
