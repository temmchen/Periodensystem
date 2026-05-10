import SwiftUI

enum AppPalette {
    static let bgTop      = Color(red: 0x0f/255, green: 0x12/255, blue: 0x26/255)
    static let bgBottom   = Color(red: 0x1a/255, green: 0x1f/255, blue: 0x3d/255)
    static let panel      = Color(red: 0x1a/255, green: 0x1f/255, blue: 0x3d/255)
    static let text       = Color(red: 0xe8/255, green: 0xec/255, blue: 0xf8/255)
    static let muted      = Color(red: 0x9a/255, green: 0xa3/255, blue: 0xc4/255)
    static let accent     = Color(red: 0x5f/255, green: 0xc3/255, blue: 0xff/255)
    static let border     = Color(red: 0x2a/255, green: 0x31/255, blue: 0x55/255)
    static let cellInk    = Color(red: 0x0f/255, green: 0x12/255, blue: 0x26/255)
}

struct ContentView: View {
    @State private var selected: Element?

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                Text("Periodensystem der Elemente")
                    .font(.system(size: 28, weight: .semibold))
                    .kerning(0.5)
                    .foregroundStyle(AppPalette.text)
                    .padding(.top, 24)

                Text("Klicke auf ein Element für Details (DE/FR/EN/Latein, Technik, Chemie, Aggregatzustände)")
                    .font(.system(size: 14))
                    .foregroundStyle(AppPalette.muted)

                LegendView()
                    .padding(.vertical, 8)

                PeriodicTableView(selected: $selected)
                    .frame(maxWidth: 1400)
                    .padding(.horizontal, 8)

                Text("© Tom BLEYER · 05/2026 · Alle Rechte vorbehalten")
                    .font(.system(size: 13))
                    .kerning(0.5)
                    .foregroundStyle(AppPalette.muted)
                    .padding(.top, 32)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .top) {
                        Rectangle()
                            .fill(AppPalette.border)
                            .frame(height: 1)
                    }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
        }
        .background(
            LinearGradient(
                colors: [AppPalette.bgTop, AppPalette.bgBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .preferredColorScheme(.dark)
        .sheet(item: $selected) { element in
            ElementDetailView(element: element) { selected = nil }
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 1200, height: 800)
}
