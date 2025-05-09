import SwiftUI

struct LoadingPlaceholderView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(height: 20)
            .shimmering()
    }
}

extension View {
    func shimmering() -> some View {
        self
            .redacted(reason: .placeholder)
            .overlay(
                GradientMask()
                    .mask(self)
            )
    }
}

struct GradientMask: View {
    @State private var move = false
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.clear, .white.opacity(0.6), .clear]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .rotationEffect(.degrees(30))
        .offset(x: move ? 600 : -600)
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                move.toggle()
            }
        }
    }
}
