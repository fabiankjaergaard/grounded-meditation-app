//
//  MeditationTimerView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import SwiftUI

struct MeditationTimerView: View {
    @Environment(\.dismiss) var dismiss
    let meditation: Meditation
    let onComplete: () -> Void

    @State private var currentPhase = 1
    @State private var timeRemaining: Int = 0
    @State private var totalPhaseTime: Int = 0
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var showExitConfirmation = false

    // Phase data for each meditation
    private var phases: [(duration: Int, name: String, description: String)] {
        if meditation.id == "dynamic" {
            return [
                (10, "Chaotic Breathing", "Breathe chaotically through the nose"),
                (10, "Catharsis", "Explode! Let go of everything"),
                (10, "The Mantra", "Jump and shout 'Hoo! Hoo! Hoo!'"),
                (15, "Silence", "Stop! Freeze wherever you are"),
                (15, "Celebration", "Dance and celebrate")
            ]
        } else if meditation.id == "kundalini" {
            return [
                (15, "Shaking", "Let your body shake from the feet up"),
                (15, "Dancing", "Dance freely in any way you feel"),
                (15, "Witnessing", "Sit still and observe"),
                (15, "Stillness", "Lie down and be still")
            ]
        } else {
            return [(10, "Meditation", "Breathe and relax")]
        }
    }

    private var currentPhaseData: (duration: Int, name: String, description: String)? {
        guard currentPhase > 0 && currentPhase <= phases.count else { return nil }
        return phases[currentPhase - 1]
    }

    var progress: Double {
        guard totalPhaseTime > 0 else { return 0 }
        return Double(totalPhaseTime - timeRemaining) / Double(totalPhaseTime)
    }

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Constants.Colors.primaryBlue,
                    Constants.Colors.primaryBlue.opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                // Close button
                HStack {
                    Spacer()
                    Button(action: {
                        if isRunning {
                            showExitConfirmation = true
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, Constants.Spacing.standard)
                .padding(.top, 60)

                Spacer()

                // Current phase info
                if let phaseData = currentPhaseData {
                    VStack(spacing: 20) {
                        Text("Phase \(currentPhase) of \(phases.count)")
                            .font(Constants.Typography.caption)
                            .foregroundColor(.white.opacity(0.8))

                        Text(phaseData.name)
                            .font(Constants.Typography.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        Text(phaseData.description)
                            .font(Constants.Typography.body)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, Constants.Spacing.xl)
                    }
                }

                // Timer circle
                ZStack {
                    // Background circle
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 12)
                        .frame(width: 240, height: 240)

                    // Progress circle
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.white, lineWidth: 12)
                        .frame(width: 240, height: 240)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: progress)

                    // Time text
                    VStack(spacing: 8) {
                        Text(timeString(from: timeRemaining))
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Text("remaining")
                            .font(Constants.Typography.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }

                Spacer()

                // Control buttons
                HStack(spacing: 20) {
                    if currentPhase > 1 {
                        Button(action: previousPhase) {
                            Image(systemName: "backward.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }

                    Button(action: togglePlayPause) {
                        Image(systemName: isRunning ? "pause.fill" : "play.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Circle())
                    }

                    if currentPhase < phases.count {
                        Button(action: nextPhase) {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear(perform: setupTimer)
        .onDisappear(perform: stopTimer)
        .alert("Exit Meditation?", isPresented: $showExitConfirmation) {
            Button("Continue", role: .cancel) { }
            Button("Exit", role: .destructive) {
                stopTimer()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to stop the meditation?")
        }
    }

    // MARK: - Timer Methods
    private func setupTimer() {
        if let phaseData = currentPhaseData {
            totalPhaseTime = phaseData.duration * 60
            timeRemaining = totalPhaseTime
        }
    }

    private func togglePlayPause() {
        if isRunning {
            pauseTimer()
        } else {
            startTimer()
        }
    }

    private func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // Phase complete
                if currentPhase < phases.count {
                    nextPhase()
                } else {
                    // Meditation complete
                    completeMeditation()
                }
            }
        }
    }

    private func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func nextPhase() {
        stopTimer()
        if currentPhase < phases.count {
            currentPhase += 1
            setupTimer()
        }
    }

    private func previousPhase() {
        stopTimer()
        if currentPhase > 1 {
            currentPhase -= 1
            setupTimer()
        }
    }

    private func completeMeditation() {
        stopTimer()
        onComplete()
    }

    private func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    MeditationTimerView(meditation: .dynamicMeditation) {
        print("Meditation completed")
    }
}
