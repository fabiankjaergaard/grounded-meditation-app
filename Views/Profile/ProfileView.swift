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
    @State private var showResetAlert = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Profile header
                    profileHeader

                    // Stats
                    statsSection
                        .padding(.horizontal, Constants.Spacing.standard)
                        .padding(.top, Constants.Spacing.standard)

                    // Options
                    optionsSection
                        .padding(Constants.Spacing.standard)
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Constants.Colors.backgroundBeige)
            .navigationBarHidden(true)
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .alert("Reset dagens aktiviteter?", isPresented: $showResetAlert) {
                Button("Avbryt", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    viewModel.resetTodaysActivities()
                }
            } message: {
                Text("Detta kommer att ta bort alla checkmarkeringar för dagens aktiviteter.")
            }
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        ZStack {
            // Background image
            Image("Blue-background")
                .resizable()
                .scaledToFill()
                .frame(height: 280)
                .clipped()

            VStack(spacing: Constants.Spacing.md) {
                Spacer()
                    .frame(height: 60)

                // Profile image
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.2))
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
                            .foregroundColor(.white)
                    }
                }

                // Name
                Text(viewModel.userData.name.isEmpty ? "Gäst" : viewModel.userData.name)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)

                // Join date
                Text("Medlem sedan \(viewModel.userData.joinDate.shortDateString)")
                    .font(Constants.Typography.body)
                    .foregroundColor(.white.opacity(0.9))

                Spacer()
                    .frame(height: Constants.Spacing.standard)
            }
        }
        .frame(height: 280)
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

            // Temporary reset button for testing
            OptionRow(icon: "arrow.counterclockwise.circle.fill", title: "🔧 Reset dagens aktiviteter") {
                showResetAlert = true
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

    func resetTodaysActivities() {
        StorageManager.shared.resetTodaysActivities()
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
