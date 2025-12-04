//
//  YouTubePlayerView.swift
//  Grounded
//
//  Created by Fabian Kjaergaard on 2025-12-04.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)?playsinline=1") else {
            return
        }

        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    YouTubePlayerView(videoID: "oGDLVkYKgAo")
        .frame(height: 220)
}
