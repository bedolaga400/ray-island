import SwiftUI

struct SoraView: View {
    var pose: String
    var size: CGFloat = 24

    private var closed: Bool { pose == "sleep" || pose == "fanta" }
    private var openMouth: Bool { pose == "wave" || pose == "fanta" }

    var body: some View {
        let u = size / 24
        let hair = Color(red: 0.66, green: 0.80, blue: 0.95)
        ZStack {
            Capsule().fill(Color(red: 0.53, green: 0.70, blue: 0.89))
                .frame(width: 2 * u, height: 6 * u)
                .offset(y: -12 * u)
            Ellipse().fill(hair)
                .frame(width: 24 * u, height: 22 * u)
            Ellipse().fill(Color(red: 0.99, green: 0.94, blue: 0.92))
                .frame(width: 18 * u, height: 15 * u)
                .offset(y: 3 * u)
            HStack(spacing: 5 * u) {
                eye(u)
                eye(u)
            }
            .offset(y: 2 * u)
            HStack(spacing: 11 * u) {
                blush(u)
                blush(u)
            }
            .offset(y: 6 * u)
            mouth(u).offset(y: 8 * u)
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder private func eye(_ u: CGFloat) -> some View {
        if closed {
            Capsule().fill(Color(red: 0.48, green: 0.16, blue: 0.2))
                .frame(width: 4 * u, height: 1.4 * u)
        } else {
            Capsule().fill(Color(red: 0.83, green: 0.19, blue: 0.24))
                .frame(width: 3.2 * u, height: 4.6 * u)
        }
    }

    private func blush(_ u: CGFloat) -> some View {
        let strong = pose == "fanta" || pose == "cat" || pose == "wave"
        return Ellipse().fill(Color.pink.opacity(strong ? 0.7 : 0.35))
            .frame(width: 4 * u, height: 2.5 * u)
    }

    @ViewBuilder private func mouth(_ u: CGFloat) -> some View {
        if openMouth {
            Circle().fill(Color(red: 0.7, green: 0.35, blue: 0.38))
                .frame(width: 3 * u, height: 3 * u)
        } else {
            Capsule().fill(Color(red: 0.7, green: 0.35, blue: 0.38))
                .frame(width: 4 * u, height: 1.3 * u)
        }
    }
}

struct CanView: View {
    var height: CGFloat = 16

    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(LinearGradient(
                colors: [Color(red: 0.9, green: 0.42, blue: 0),
                         Color(red: 1, green: 0.55, blue: 0.08),
                         Color(red: 1, green: 0.75, blue: 0.4),
                         Color(red: 0.85, green: 0.37, blue: 0)],
                startPoint: .leading, endPoint: .trailing))
            .frame(width: height * 0.62, height: height)
            .overlay(alignment: .top) {
                Rectangle().fill(Color(white: 0.85)).frame(height: height * 0.14)
            }
            .overlay(alignment: .bottom) {
                Rectangle().fill(Color(white: 0.72)).frame(height: height * 0.12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 2))
    }
}

struct PropView: View {
    var pose: String
    var size: CGFloat = 24

    var body: some View {
        switch pose {
        case "fanta": CanView(height: size)
        case "cat": Text("🐱").font(.system(size: size * 0.9))
        case "music": Text("🎵").font(.system(size: size * 0.9))
        case "sleep": Text("💤").font(.system(size: size * 0.9))
        case "wave": Text("👋").font(.system(size: size * 0.9))
        default: EmptyView()
        }
    }
}
