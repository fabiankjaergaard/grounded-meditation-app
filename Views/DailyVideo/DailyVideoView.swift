//
//  DailyVideoView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import Combine

struct DailyVideoView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = DailyVideoViewModel()
    let onComplete: () -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.standard) {
                    // Video placeholder (YouTube integration needed)
                    videoSection

                    // Video info
                    videoInfoSection

                    // Reflection section
                    reflectionSection
                }
                .padding(Constants.Spacing.standard)
            }
            .background(Constants.Colors.backgroundBeige)
            .navigationTitle("Dagens Reflektion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Constants.Colors.textPrimary)
                    }
                }
            }
            .onAppear {
                viewModel.loadReflection()
            }
        }
    }

    // MARK: - Video Section
    private var videoSection: some View {
        VStack(spacing: 12) {
            // YouTube Player
            YouTubePlayerView(videoID: viewModel.videoId)
                .aspectRatio(16/9, contentMode: .fit)
                .cornerRadius(Constants.CornerRadius.card)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                        .stroke(Constants.Colors.borderLight, lineWidth: 1)
                )
        }
    }

    // MARK: - Video Info Section
    private var videoInfoSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Om Reflections of Life")
                    .font(Constants.Typography.bodyBold)
                    .foregroundColor(Constants.Colors.textPrimary)

                Spacer()

                Button(action: {
                    viewModel.isInfoExpanded.toggle()
                }) {
                    Image(systemName: viewModel.isInfoExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Constants.Colors.textSecondary)
                }
            }

            if viewModel.isInfoExpanded {
                Text("Reflections of Life är en serie med inspirerande videos som utforskar livets djupare frågor och erbjuder visdom för din inre resa.")
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
                    .lineSpacing(4)

                Link(destination: URL(string: "https://www.youtube.com/watch?v=\(viewModel.videoId)")!) {
                    HStack {
                        Text("Se på YouTube")
                        Image(systemName: "arrow.up.right")
                    }
                    .font(Constants.Typography.subheadline)
                    .foregroundColor(Constants.Colors.primaryBlue)
                }
            }
        }
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Reflection Section
    private var reflectionSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "pencil")
                    .foregroundColor(Constants.Colors.primaryBlue)
                Text("Din reflektion")
                    .font(Constants.Typography.bodyBold)
                    .foregroundColor(Constants.Colors.textPrimary)
            }

            if viewModel.isSaved {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text("Reflektion sparad")
                            .font(Constants.Typography.subheadline)
                            .foregroundColor(.green)
                    }

                    Text(viewModel.reflectionText)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textPrimary)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                    Button(action: {
                        viewModel.isSaved = false
                    }) {
                        Text("Redigera")
                            .font(Constants.Typography.subheadline)
                            .foregroundColor(Constants.Colors.primaryBlue)
                    }
                }
            } else {
                TextEditor(text: $viewModel.reflectionText)
                    .frame(height: 150)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Constants.Colors.borderLight, lineWidth: 1)
                    )
                    .overlay(
                        Group {
                            if viewModel.reflectionText.isEmpty {
                                Text("Vad väckte denna video inom dig?")
                                    .foregroundColor(Constants.Colors.textTertiary)
                                    .padding(16)
                                    .allowsHitTesting(false)
                            }
                        },
                        alignment: .topLeading
                    )

                Button(action: {
                    viewModel.saveReflection()
                }) {
                    Text("Spara reflektion")
                        .font(Constants.Typography.bodyBold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Constants.Colors.primaryBlue)
                        .cornerRadius(Constants.CornerRadius.button)
                }
                .disabled(viewModel.reflectionText.isEmpty)
                .opacity(viewModel.reflectionText.isEmpty ? 0.5 : 1.0)
            }
        }
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }
}

// MARK: - ViewModel
class DailyVideoViewModel: ObservableObject {
    @Published var reflectionText: String = ""
    @Published var isSaved: Bool = false
    @Published var isInfoExpanded: Bool = false

    private let storageManager = StorageManager.shared
    let videoId: String

    init() {
        self.videoId = Constants.VideoIDs.getDailyReflectionVideo()
    }

    func loadReflection() {
        if let existingReflection = storageManager.getReflection(for: videoId) {
            reflectionText = existingReflection.text
            isSaved = true
        }
    }

    func saveReflection() {
        let reflection = Reflection(
            videoId: videoId,
            text: reflectionText,
            date: Date()
        )
        storageManager.saveReflection(reflection)
        isSaved = true

        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    DailyVideoView {
        print("Completed!")
    }
}
