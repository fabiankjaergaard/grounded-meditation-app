//
//  HomeView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = HomeViewModel()
    @State private var showActivityTypeSelection = false
    @State private var showBreathwork = false
    @State private var showDailyQuote = false
    @State private var showDailyVideo = false
    @State private var breathworkPatternKey = "morning"

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    dailyJourneySection
                    bonusSection
                }
            }
            .ignoresSafeArea(edges: .top)
            .background(Constants.Colors.backgroundBeige)
            .navigationBarHidden(true)
            .onAppear {
                viewModel.refreshData()
            }
            .sheet(isPresented: $showActivityTypeSelection) {
                ActivityTypeSelectionView { activityType, duration in
                    if activityType == .breathwork {
                        // TODO: Use duration for breathwork
                        breathworkPatternKey = "morning"
                        showBreathwork = true
                    } else {
                        // TODO: Navigate to meditation with selected duration
                        print("Start meditation for \(duration) minutes")
                    }
                }
            }
            .sheet(isPresented: $showBreathwork) {
                BreathworkView(patternKey: breathworkPatternKey) {
                    viewModel.completeActivity("morning_breath")
                }
            }
            .sheet(isPresented: $showDailyQuote) {
                DailyQuoteScreen {
                    viewModel.completeActivity("midday_reset")
                }
            }
            .sheet(isPresented: $showDailyVideo) {
                DailyVideoView {
                    viewModel.completeActivity("evening_reflection")
                }
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        ZStack {
            // Background image
            Image("Blue-background")
                .resizable()
                .scaledToFill()
                .frame(height: 320)
                .clipped()

            VStack(spacing: Constants.Spacing.md) {
                Spacer()
                    .frame(height: 60)

                // Greeting
                Text(viewModel.greeting)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Constants.Spacing.standard)

                // Quote card
                QuoteCard(
                    quote: viewModel.dailyQuote.text,
                    author: viewModel.dailyQuote.author
                )
                .padding(.horizontal, Constants.Spacing.standard)
                .padding(.bottom, Constants.Spacing.lg)
            }
        }
        .frame(height: 320)
    }

    // MARK: - Daily Journey Section
    private var dailyJourneySection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.md) {
            // Section title
            VStack(alignment: .leading, spacing: 4) {
                Text("Dagens resa")
                    .font(Constants.Typography.headline)
                    .foregroundColor(Constants.Colors.textPrimary)

                Text("Tre enkla praktiker för att behålla Baravara-känslan i vardagen")
                    .font(Constants.Typography.subheadline)
                    .foregroundColor(Constants.Colors.textSecondary)
            }
            .padding(.horizontal, Constants.Spacing.standard)

            // Activities with timeline
            VStack(spacing: 12) {
                ForEach(Array(viewModel.dailyActivities.enumerated()), id: \.element.id) { index, activity in
                    HStack(alignment: .center, spacing: 16) {
                        // Prick med streck i bakgrunden
                        ZStack {
                            // Streck bakom pricken - från botten av cirkel till toppen av nästa
                            if index < viewModel.dailyActivities.count - 1 {
                                Rectangle()
                                    .fill(activity.isCompleted ? Constants.Colors.primaryBlue : Color.gray.opacity(0.2))
                                    .frame(width: 2, height: 78)
                                    .offset(y: 51) // Börjar vid botten av cirkel (y:12) och slutar vid toppen av nästa (y:-12)
                            }

                            // Prick
                            TimelineView(isCompleted: activity.isCompleted)
                        }

                        // Activity card
                        DailyActivityCard(activity: activity) {
                            handleActivityTap(activity)
                        }
                    }
                    .padding(.horizontal, Constants.Spacing.standard)
                }
            }
            .padding(.top, Constants.Spacing.sm)
        }
        .padding(.vertical, Constants.Spacing.standard)
    }

    // MARK: - Bonus Section
    @ViewBuilder
    private var bonusSection: some View {
        if let bonusActivity = viewModel.bonusActivity {
            BonusActivityCard(activity: bonusActivity) {
                handleBonusActivityTap(bonusActivity)
            }
            .padding(.horizontal, Constants.Spacing.standard)
            .padding(.bottom, Constants.Spacing.xl)
        }
    }

    // MARK: - Actions
    private func handleActivityTap(_ activity: Activity) {
        switch activity.type {
        case .breathwork, .meditation:
            // Show activity type selection for morning activity
            showActivityTypeSelection = true
        case .quote:
            showDailyQuote = true
        case .video:
            showDailyVideo = true
        }
    }

    private func handleBonusActivityTap(_ activity: Activity) {
        print("Navigate to Meditation: \(activity.id)")
        // TODO: Navigate to meditation detail screen
    }
}

#Preview {
    HomeView()
}
