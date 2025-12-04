//
//  BreathworkView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct BreathworkView: View {
    @Environment(\.dismiss) var dismiss
    let patternKey: String
    let onComplete: () -> Void

    @State private var showModeSelection = false
    @State private var showDurationSelection = false
    @State private var showInteractive = false
    @State private var selectedMode: BreathworkMode?
    @State private var selectedDuration: Int?

    var body: some View {
        Color.clear
            .onAppear {
                // For morning breathwork, show mode selection
                if patternKey == "morning" {
                    showModeSelection = true
                } else {
                    // For other patterns, go directly to interactive
                    showInteractive = true
                }
            }
            .sheet(isPresented: $showModeSelection) {
                ModeSelectionView(patternKey: patternKey) { mode in
                    selectedMode = mode
                    showModeSelection = false

                    if mode == .video {
                        showDurationSelection = true
                    } else {
                        showInteractive = true
                    }
                }
            }
            .sheet(isPresented: $showDurationSelection) {
                DurationSelectionView(activityType: .breathwork) { duration in
                    selectedDuration = duration
                    showDurationSelection = false
                    // TODO: Show video player with selected duration
                    print("Show video for \(duration) minutes")
                    dismiss()
                }
            }
            .fullScreenCover(isPresented: $showInteractive) {
                InteractiveBreathworkView(patternKey: patternKey) {
                    onComplete()
                    showInteractive = false
                    dismiss()
                }
            }
    }
}

#Preview {
    BreathworkView(patternKey: "morning") {
        print("Completed!")
    }
}
