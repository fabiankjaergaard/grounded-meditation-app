//
//  MapView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686), // Stockholm
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    var body: some View {
        NavigationStack {
            ZStack {
                // Map
                Map(position: $position) {
                    UserAnnotation()
                }
                .ignoresSafeArea()

                // Coming soon overlay
                VStack {
                    Spacer()

                    VStack(spacing: 12) {
                        Image(systemName: "map.fill")
                            .font(.system(size: 48))
                            .foregroundColor(Constants.Colors.primaryBlue)

                        Text("Upptäck")
                            .font(Constants.Typography.headline)
                            .foregroundColor(Constants.Colors.textPrimary)

                        Text("Kartan kommer snart visa yoga-studior och meditationscenters i din närhet")
                            .font(Constants.Typography.body)
                            .foregroundColor(Constants.Colors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(Constants.Spacing.standard)
                    .background(
                        RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                            .fill(Color.white)
                            .shadow(
                                color: Constants.Shadow.color,
                                radius: Constants.Shadow.radius,
                                x: Constants.Shadow.x,
                                y: Constants.Shadow.y
                            )
                    )
                    .padding(Constants.Spacing.standard)
                    .padding(.bottom, 60)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MapView()
}
