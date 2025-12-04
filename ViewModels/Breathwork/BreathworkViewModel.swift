//
//  BreathworkViewModel.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class BreathworkViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentPhase: BreathPhaseType = .idle
    @Published var phaseText: String = "Börja när du är redo"
    @Published var currentRound: Int = 0
    @Published var isRunning: Bool = false
    @Published var isCompleted: Bool = false
    @Published var circleScale: CGFloat = 1.0

    // MARK: - Private Properties
    private var pattern: Constants.BreathPattern
    private var totalRounds: Int = 5
    private var currentPhaseIndex: Int = 0
    private var timer: Timer?
    private var phaseStartTime: Date?

    // MARK: - Initialization
    init(patternKey: String = "morning") {
        self.pattern = Constants.breathPatterns[patternKey] ?? Constants.breathPatterns["morning"]!
    }

    // MARK: - Public Methods
    func start() {
        guard !isRunning else { return }
        isRunning = true
        currentRound = 1
        currentPhaseIndex = 0
        isCompleted = false
        startNextPhase()
    }

    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        currentPhase = .idle
        phaseText = "Pausad"
        circleScale = 1.0
    }

    func complete() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        isCompleted = true
        currentPhase = .idle
        phaseText = "Färdig!"
    }

    // MARK: - Private Methods
    private func startNextPhase() {
        guard isRunning else { return }

        let phase = pattern.phases[currentPhaseIndex]
        currentPhase = phase.type.breathPhaseType
        phaseText = phase.text
        phaseStartTime = Date()

        // Trigger haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        // Animate circle based on phase
        animateCircle(for: phase)

        // Schedule next phase
        timer = Timer.scheduledTimer(withTimeInterval: phase.duration, repeats: false) { [weak self] _ in
            self?.moveToNextPhase()
        }
    }

    private func moveToNextPhase() {
        currentPhaseIndex += 1

        // Check if we completed all phases in this round
        if currentPhaseIndex >= pattern.phases.count {
            currentPhaseIndex = 0
            currentRound += 1

            // Check if we completed all rounds
            if currentRound > totalRounds {
                complete()
                return
            }
        }

        startNextPhase()
    }

    private func animateCircle(for phase: Constants.BreathPattern.BreathPhase) {
        withAnimation(.easeInOut(duration: phase.duration)) {
            switch phase.type {
            case .inhale:
                circleScale = 1.5
            case .exhale:
                circleScale = 0.7
            case .hold:
                // Keep current size
                break
            }
        }
    }

    // MARK: - Computed Properties
    var progress: Double {
        let totalPhases = pattern.phases.count * totalRounds
        let completedPhases = (currentRound - 1) * pattern.phases.count + currentPhaseIndex
        return Double(completedPhases) / Double(totalPhases)
    }

    var gradient: LinearGradient {
        switch currentPhase {
        case .inhale:
            return .inhaleGradient
        case .exhale:
            return .exhaleGradient
        case .hold:
            return .holdGradient
        case .idle:
            return LinearGradient(
                colors: [Constants.Colors.backgroundBeige, Constants.Colors.backgroundBeige],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// MARK: - Breath Phase Type
enum BreathPhaseType: Hashable {
    case idle
    case inhale
    case hold
    case exhale
}

// Extend Constants.BreathPattern.BreathPhase.PhaseType to match
extension Constants.BreathPattern.BreathPhase.PhaseType {
    var breathPhaseType: BreathPhaseType {
        switch self {
        case .inhale: return .inhale
        case .hold: return .hold
        case .exhale: return .exhale
        }
    }
}
