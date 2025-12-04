//
//  MeditationDetailView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import SwiftUI

struct MeditationDetailView: View {
    @Environment(\.dismiss) var dismiss
    let meditation: MeditationType
    @State private var showInstructions = false
    @State private var showTimer = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Spacing.standard) {
                // Hero image/gradient
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Constants.Colors.primaryBlue,
                            Constants.Colors.primaryBlue.opacity(0.7)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 200)

                    VStack(spacing: 8) {
                        Image(systemName: meditation.icon)
                            .font(.system(size: 60))
                            .foregroundColor(.white)

                        Text(meditation.title)
                            .font(Constants.Typography.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Text("\(meditation.duration) min")
                            .font(Constants.Typography.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }

                VStack(alignment: .leading, spacing: Constants.Spacing.md) {
                    // Description
                    Text("About")
                        .font(Constants.Typography.headline)
                        .foregroundColor(Constants.Colors.textPrimary)

                    Text(meditation.description)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textSecondary)
                        .lineSpacing(4)

                    // Instructions toggle
                    Button(action: {
                        withAnimation {
                            showInstructions.toggle()
                        }
                    }) {
                        HStack {
                            Text("Instructions")
                                .font(Constants.Typography.headline)
                                .foregroundColor(Constants.Colors.textPrimary)

                            Spacer()

                            Image(systemName: showInstructions ? "chevron.up" : "chevron.down")
                                .foregroundColor(Constants.Colors.accentOrange)
                        }
                        .padding(.vertical, 8)
                    }

                    if showInstructions {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(Array(meditation.instructions.enumerated()), id: \.offset) { index, instruction in
                                HStack(alignment: .top, spacing: 12) {
                                    Text("\(index + 1).")
                                        .font(Constants.Typography.bodyBold)
                                        .foregroundColor(Constants.Colors.accentOrange)

                                    Text(instruction)
                                        .font(Constants.Typography.body)
                                        .foregroundColor(Constants.Colors.textSecondary)
                                        .lineSpacing(4)
                                }
                            }
                        }
                        .transition(.opacity)
                    }

                    // Phases
                    if !meditation.phases.isEmpty {
                        Divider()
                            .padding(.vertical, 8)

                        Text("Phases")
                            .font(Constants.Typography.headline)
                            .foregroundColor(Constants.Colors.textPrimary)

                        VStack(spacing: 12) {
                            ForEach(meditation.phases) { phase in
                                PhaseCard(phase: phase)
                            }
                        }
                    }
                }
                .padding(.horizontal, Constants.Spacing.standard)
                .padding(.bottom, 100) // Space for button
            }
        }
        .background(Constants.Colors.backgroundBeige)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(
            // Floating start button
            VStack {
                Spacer()

                Button(action: {
                    showTimer = true
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                            .font(.system(size: 20))
                        Text("Start Meditation")
                            .font(Constants.Typography.bodyBold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(Constants.Colors.primaryBlue)
                    .cornerRadius(Constants.CornerRadius.button)
                    .shadow(
                        color: Constants.Shadow.color,
                        radius: Constants.Shadow.radius,
                        x: Constants.Shadow.x,
                        y: Constants.Shadow.y
                    )
                }
                .padding(.horizontal, Constants.Spacing.standard)
                .padding(.bottom, Constants.Spacing.standard)
            }
        )
        .fullScreenCover(isPresented: $showTimer) {
            MeditationTimerView(meditation: meditation) {
                showTimer = false
                dismiss()
            }
        }
    }
}

// MARK: - Phase Card
struct PhaseCard: View {
    let phase: MeditationPhase

    var body: some View {
        HStack(spacing: 12) {
            // Phase number
            ZStack {
                Circle()
                    .fill(Constants.Colors.accentOrange.opacity(0.1))
                    .frame(width: 40, height: 40)

                Text("\(phase.order)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Constants.Colors.accentOrange)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(phase.name)
                    .font(Constants.Typography.bodyBold)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text("\(phase.duration) min")
                    .font(Constants.Typography.caption)
                    .foregroundColor(Constants.Colors.textSecondary)
            }

            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                .stroke(Constants.Colors.borderDefault, lineWidth: 1)
        )
    }
}

// MARK: - Meditation Models
struct MeditationType: Identifiable {
    let id: String
    let title: String
    let description: String
    let duration: Int
    let icon: String
    let instructions: [String]
    let phases: [MeditationPhase]
}

struct MeditationPhase: Identifiable {
    let id = UUID()
    let order: Int
    let name: String
    let duration: Int
    let description: String
}

// MARK: - Meditation Types
extension MeditationType {
    static let dynamic = MeditationType(
        id: "dynamic",
        title: "Dynamic Meditation",
        description: "A revolutionary meditation technique designed by Osho to release accumulated stress and tension in the body-mind. This active meditation uses chaotic breathing, catharsis, and celebration to break old patterns and create space for silence and stillness.",
        duration: 60,
        icon: "bolt.fill",
        instructions: [
            "Wear comfortable, loose clothing and ensure you have enough space to move freely",
            "It's best to do this meditation on an empty stomach, in the early morning if possible",
            "Keep your eyes closed throughout all stages using a blindfold if needed",
            "Let your body move naturally - don't force anything",
            "Be total in each stage - give 100% of your energy"
        ],
        phases: [
            MeditationPhase(
                order: 1,
                name: "Chaotic Breathing",
                duration: 10,
                description: "Breathe chaotically through the nose, concentrating always on the exhalation"
            ),
            MeditationPhase(
                order: 2,
                name: "Catharsis",
                duration: 10,
                description: "Explode! Let go of everything that needs to be thrown out. Go totally mad"
            ),
            MeditationPhase(
                order: 3,
                name: "The Sufi Mantra",
                duration: 10,
                description: "With arms raised high, jump up and down shouting 'Hoo! Hoo! Hoo!'"
            ),
            MeditationPhase(
                order: 4,
                name: "Silence",
                duration: 15,
                description: "Stop! Freeze wherever you are. Don't arrange the body in any way"
            ),
            MeditationPhase(
                order: 5,
                name: "Celebration",
                duration: 15,
                description: "Celebrate with music and dance, expressing your gratitude"
            )
        ]
    )

    static let kundalini = MeditationType(
        id: "kundalini",
        title: "Kundalini Meditation",
        description: "A gentle yet powerful evening meditation that allows your energy to flow and shake off the day's stress. Perfect for unwinding and letting go, this meditation uses shaking, dancing, stillness, and silence to awaken and harmonize your natural energy.",
        duration: 60,
        icon: "sparkles",
        instructions: [
            "Best done at sunset or in the late afternoon",
            "Wear loose, comfortable clothing",
            "The shaking should happen naturally - don't force it, allow it",
            "Keep your eyes closed or use a blindfold throughout",
            "Let the music guide you through each stage"
        ],
        phases: [
            MeditationPhase(
                order: 1,
                name: "Shaking",
                duration: 15,
                description: "Stand with feet shoulder-width apart and let your body shake from the feet up"
            ),
            MeditationPhase(
                order: 2,
                name: "Dancing",
                duration: 15,
                description: "Dance freely in any way you feel. Let your whole body move"
            ),
            MeditationPhase(
                order: 3,
                name: "Witnessing",
                duration: 15,
                description: "Sit or stand still, eyes closed, observing everything inside and outside"
            ),
            MeditationPhase(
                order: 4,
                name: "Stillness",
                duration: 15,
                description: "Lie down and be still, completely relaxed and silent"
            )
        ]
    )
}

#Preview {
    NavigationStack {
        MeditationDetailView(meditation: .dynamic)
    }
}
