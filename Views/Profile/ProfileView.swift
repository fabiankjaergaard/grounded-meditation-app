//
//  ProfileView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import Combine

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showSettings = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: Constants.Spacing.standard) {
                    // Profile header
                    profileHeader

                    // Stats
                    statsSection

                    // Options
                    optionsSection
                }
                .padding(Constants.Spacing.standard)
            }
            .background(Constants.Colors.backgroundBeige)
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack(spacing: 16) {
            // Profile image
            ZStack {
                Circle()
                    .fill(Constants.Colors.primaryBlue.opacity(0.1))
                    .frame(width: 100, height: 100)

                if let imageData = viewModel.userData.profileImage,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 48))
                        .foregroundColor(Constants.Colors.primaryBlue)
                }
            }

            // Name
            Text(viewModel.userData.name.isEmpty ? "Gäst" : viewModel.userData.name)
                .font(Constants.Typography.headline)
                .foregroundColor(Constants.Colors.textPrimary)

            // Join date
            Text("Medlem sedan \(viewModel.userData.joinDate.shortDateString)")
                .font(Constants.Typography.caption)
                .foregroundColor(Constants.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(Constants.Spacing.standard)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Stats Section
    private var statsSection: some View {
        HStack(spacing: 0) {
            StatItem(
                value: "\(viewModel.userData.totalSessions)",
                label: "Sessioner"
            )

            Divider()
                .frame(height: 50)

            StatItem(
                value: "\(viewModel.userData.currentStreak)",
                label: "Streak"
            )

            Divider()
                .frame(height: 50)

            StatItem(
                value: "\(viewModel.userData.totalMinutes)",
                label: "Minuter"
            )
        }
        .padding(.vertical, Constants.Spacing.md)
        .background(Color.white)
        .cornerRadius(Constants.CornerRadius.card)
    }

    // MARK: - Options Section
    private var optionsSection: some View {
        VStack(spacing: 12) {
            OptionRow(icon: "gearshape.fill", title: "Inställningar") {
                showSettings = true
            }

            OptionRow(icon: "book.fill", title: "Mina reflektioner") {
                print("Navigate to reflections")
            }

            OptionRow(icon: "info.circle.fill", title: "Om appen") {
                print("Navigate to about")
            }

            OptionRow(icon: "lock.fill", title: "Integritet") {
                print("Navigate to privacy")
            }
        }
    }
}

// MARK: - Stat Item
struct StatItem: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(Constants.Typography.headline)
                .foregroundColor(Constants.Colors.primaryBlue)

            Text(label)
                .font(Constants.Typography.caption)
                .foregroundColor(Constants.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Option Row
struct OptionRow: View {
    let icon: String
    let title: String
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Constants.Colors.primaryBlue)
                    .frame(width: 32)

                Text(title)
                    .font(Constants.Typography.body)
                    .foregroundColor(Constants.Colors.textPrimary)

                Spacer()

                Image(systemName: Constants.Icons.chevronRight)
                    .font(.system(size: 14))
                    .foregroundColor(Constants.Colors.textTertiary)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(Constants.CornerRadius.button)
        }
    }
}

// MARK: - ProfileViewModel
class ProfileViewModel: ObservableObject {
    @Published var userData: UserData

    init() {
        self.userData = StorageManager.shared.getUserData() ?? UserData()
    }
}

// MARK: - Settings View (Placeholder)
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section("Konto") {
                    Text("Redigera profil")
                }

                Section("Notifikationer") {
                    Toggle("Dagliga påminnelser", isOn: .constant(true))
                }
            }
            .navigationTitle("Inställningar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Klar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
