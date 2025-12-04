//
//  MainTabView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home
            HomeView()
                .tabItem {
                    Label("Hem", systemImage: Constants.Icons.home)
                }
                .tag(0)

            // Community (Locked)
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: Constants.Icons.community)
                }
                .tag(1)

            // Meditations
            MeditationsListView()
                .tabItem {
                    Label("Meditera", systemImage: Constants.Icons.meditations)
                }
                .tag(2)

            // Map
            MapView()
                .tabItem {
                    Label("Upptäck", systemImage: Constants.Icons.map)
                }
                .tag(3)

            // Profile
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: Constants.Icons.profile)
                }
                .tag(4)
        }
        .accentColor(Constants.Colors.primaryBlue)
    }
}

#Preview {
    MainTabView()
}
