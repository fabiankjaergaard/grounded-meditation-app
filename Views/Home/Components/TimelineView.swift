//
//  TimelineView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct TimelineView: View {
    let isCompleted: Bool

    var body: some View {
        Circle()
            .fill(isCompleted ? Constants.Colors.primaryBlue : Color.clear)
            .frame(width: 24, height: 24)
            .overlay(
                Circle()
                    .stroke(
                        isCompleted ? Constants.Colors.primaryBlue : Color.gray.opacity(0.3),
                        lineWidth: 4
                    )
            )
            .overlay(
                Image(systemName: "checkmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .opacity(isCompleted ? 1 : 0)
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        TimelineView(isCompleted: true)
        TimelineView(isCompleted: false)
    }
}
