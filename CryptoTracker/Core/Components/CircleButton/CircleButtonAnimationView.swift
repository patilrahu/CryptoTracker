//
//  CircleButtonAnimationView.swift
//  CryptoTracker
//
//  Created by Apple on 20/10/25.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var isAnimating: Bool
    var body: some View {
        Circle().stroke(lineWidth: 5.0)
            .scale(isAnimating ? 1.0 : 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(isAnimating ? .easeInOut(duration: 1.0) : .none)
            .onAppear {
                isAnimating.toggle()
            }
    }
}

#Preview {
    CircleButtonAnimationView(isAnimating: .constant(false))
}
