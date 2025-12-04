//
//  InteractiveBreathworkView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct InteractiveBreathworkView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: BreathworkViewModel
    let patternKey: String
    let onComplete: () -> Void

    init(patternKey: String, onComplete: @escaping () -> Void) {
        self.patternKey = patternKey
        self.onComplete = onComplete
        _viewModel = StateObject(wrappedValue: BreathworkViewModel(patternKey: patternKey))
    }

    var body: some View {
        ZStack {
            // Background gradient
            viewModel.gradient
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: viewModel.currentPhase.hashValue)

            VStack(spacing: 0) {
                // Top bar
                topBar

                Spacer()

                // Main content
                if viewModel.isCompleted {
                    completedView
                } else {
                    breathingCircle
                }

                Spacer()

                // Bottom controls
                bottomControls
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if !viewModel.isRunning {
                viewModel.start()
            }
        }
    }

    // MARK: - Top Bar
    private var topBar: some View {
        HStack {
            Button(action: {
                viewModel.stop()
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
            }

            Spacer()

            // Round counter
            if !viewModel.isCompleted {
                Text("Omgång \(viewModel.currentRound)/5")
                    .font(Constants.Typography.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
            }
        }
        .padding(Constants.Spacing.standard)
    }

    // MARK: - Breathing Circle
    private var breathingCircle: some View {
        VStack(spacing: Constants.Spacing.xl) {
            // Animated circle
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .scaleEffect(viewModel.circleScale)

                Circle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 150, height: 150)
                    .scaleEffect(viewModel.circleScale)

                Circle()
                    .fill(Color.white)
                    .frame(width: 100, height: 100)
                    .scaleEffect(viewModel.circleScale)
            }

            // Phase text
            Text(viewModel.phaseText)
                .font(Constants.Typography.headline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Completed View
    private var completedView: some View {
        VStack(spacing: Constants.Spacing.standard) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 120, height: 120)

                Image(systemName: "checkmark")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
            }

            Text("Fantastiskt!")
                .font(Constants.Typography.title)
                .foregroundColor(.white)

            Text("Du har slutfört din andningsövning")
                .font(Constants.Typography.body)
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Bottom Controls
    private var bottomControls: some View {
        VStack(spacing: 16) {
            if viewModel.isCompleted {
                Button(action: {
                    onComplete()
                    dismiss()
                }) {
                    Text("Färdig")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(Constants.Colors.primaryBlue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(Constants.CornerRadius.button)
                }
            } else {
                Button(action: {
                    viewModel.stop()
                    dismiss()
                }) {
                    Text("Avsluta")
                        .font(Constants.Typography.body)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(Constants.CornerRadius.button)
                }
            }
        }
        .padding(Constants.Spacing.standard)
    }
}

#Preview {
    InteractiveBreathworkView(patternKey: "morning") {
        print("Completed!")
    }
}
