//
//  ProfileSetupView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import PhotosUI

struct ProfileSetupView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Skapa din profil")
                    .font(Constants.Typography.title)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text("Låt oss lära känna dig lite bättre")
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Constants.Spacing.standard)
            .padding(.top, 60)

            Spacer()

            // Profile image picker
            VStack(spacing: 16) {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    ZStack {
                        if let imageData = viewModel.profileImage,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Constants.Colors.primaryBlue, lineWidth: 2)
                                )
                        } else {
                            ZStack {
                                Circle()
                                    .strokeBorder(
                                        style: StrokeStyle(lineWidth: 2, dash: [10])
                                    )
                                    .foregroundColor(Constants.Colors.borderDefault)
                                    .frame(width: 120, height: 120)

                                Image(systemName: Constants.Icons.camera)
                                    .font(.system(size: 36))
                                    .foregroundColor(Constants.Colors.textTertiary)
                            }
                        }
                    }
                }
                .onChange(of: selectedItem) { oldValue, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            viewModel.profileImage = data
                        }
                    }
                }

                Text("Lägg till profilbild")
                    .font(Constants.Typography.subheadline)
                    .foregroundColor(Constants.Colors.textSecondary)
            }

            Spacer()
                .frame(height: 40)

            // Name input
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    Image(systemName: Constants.Icons.profile)
                        .font(.system(size: 20))
                        .foregroundColor(Constants.Colors.textSecondary)
                        .frame(width: 24)

                    TextField("Ditt namn", text: $viewModel.userName)
                        .font(Constants.Typography.body)
                        .foregroundColor(Constants.Colors.textPrimary)
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(Constants.CornerRadius.input)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.CornerRadius.input)
                        .stroke(Constants.Colors.borderLight, lineWidth: 2)
                )
            }
            .padding(.horizontal, Constants.Spacing.standard)

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
                .disabled(viewModel.userName.isEmpty)
                .opacity(viewModel.userName.isEmpty ? 0.5 : 1.0)
            }
            .padding(Constants.Spacing.standard)
        }
        .background(Constants.Colors.backgroundBeige)
    }
}

#Preview {
    ProfileSetupView(viewModel: OnboardingViewModel())
}
