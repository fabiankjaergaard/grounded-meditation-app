//
//  QuoteCard.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-03.
//

import SwiftUI

struct QuoteCard: View {
    let quote: String
    let author: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(quote)
                .font(Constants.Typography.body)
                .foregroundColor(.white)
                .italic()
                .lineSpacing(4)

            Text("— \(author)")
                .font(Constants.Typography.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.Spacing.standard)
        .background(
            RoundedRectangle(cornerRadius: Constants.CornerRadius.card)
                .fill(Color.white.opacity(0.15))
        )
    }
}

#Preview {
    ZStack {
        Constants.Colors.primaryBlue
        QuoteCard(
            quote: "Be present. Be grateful. Be yourself.",
            author: "Baravara"
        )
        .padding()
    }
}
