import SwiftUI

struct ElementDetailView: View {
    let element: Element
    let onClose: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header

                section(title: "Namen in vier Sprachen") {
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), alignment: .leading),
                            GridItem(.flexible(), alignment: .leading),
                        ],
                        alignment: .leading,
                        spacing: 6
                    ) {
                        labelRow("Deutsch", element.nameDE)
                        labelRow("Französisch", element.nameFR)
                        labelRow("Englisch", element.nameEN)
                        labelRow("Latein", element.nameLA)
                    }
                }

                section(title: "Atomarer Aufbau") {
                    HStack(spacing: 10) {
                        statTile(value: "\(element.protons)", label: "Protonen")
                        statTile(value: "\(element.neutrons)", label: "Neutronen")
                        statTile(value: "\(element.electrons)", label: "Elektronen")
                    }
                    Text("Die Neutronenzahl bezieht sich auf das häufigste / stabilste Isotop.")
                        .font(.system(size: 12))
                        .foregroundStyle(AppPalette.muted)
                        .padding(.top, 4)
                }

                section(title: "Aggregatzustand & Temperaturen") {
                    HStack(spacing: 10) {
                        statTile(value: element.stateAt20C, label: "bei 20 °C")
                        statTile(value: tempC(element.meltingPointC), label: "Schmelzpunkt")
                        statTile(value: tempC(element.boilingPointC), label: "Siedepunkt")
                    }
                    Text("In Kelvin: Schmelz \(tempK(element.meltingPointC)) · Siede \(tempK(element.boilingPointC))")
                        .font(.system(size: 12))
                        .foregroundStyle(AppPalette.muted)
                        .padding(.top, 4)
                }

                section(title: "Anwendungen in der Technik (Elektrotechnik zuerst)") {
                    bulletList(element.techApplications)
                }

                section(title: "Häufige chemische Verbindungen") {
                    bulletList(element.compounds)
                }
            }
            .padding(28)
            .frame(maxWidth: 760, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(AppPalette.panel)
        .preferredColorScheme(.dark)
        .frame(minWidth: 640, idealWidth: 780, minHeight: 520, idealHeight: 700)
        .overlay(alignment: .topTrailing) {
            Button(action: onClose) {
                ZStack {
                    Circle()
                        .fill(Color(red: 1.0, green: 0x54/255, blue: 0x70/255))
                        .frame(width: 34, height: 34)
                    Text("×")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                }
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(.plain)
            .keyboardShortcut(.cancelAction)
            .padding(14)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(element.nameDE)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(AppPalette.accent)
                Text("(\(element.symbol))")
                    .font(.system(size: 18))
                    .foregroundStyle(AppPalette.muted)
            }
            Text("Ordnungszahl \(element.z) · Atommasse \(formatMass(element.mass)) u · Kategorie: \(element.category.displayName)")
                .font(.system(size: 14))
                .foregroundStyle(AppPalette.muted)
        }
        .padding(.bottom, 4)
    }

    @ViewBuilder
    private func section<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Rectangle()
                .fill(AppPalette.accent)
                .frame(width: 3)
            VStack(alignment: .leading, spacing: 6) {
                Text(title.uppercased())
                    .font(.system(size: 13, weight: .semibold))
                    .kerning(0.6)
                    .foregroundStyle(AppPalette.accent)
                content()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.white.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private func labelRow(_ label: String, _ value: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(label + ":")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(AppPalette.text)
            Text(value)
                .font(.system(size: 14))
                .foregroundStyle(AppPalette.text)
        }
    }

    private func statTile(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(AppPalette.accent)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(label.uppercased())
                .font(.system(size: 11))
                .kerning(0.4)
                .foregroundStyle(AppPalette.muted)
                .multilineTextAlignment(.center)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(AppPalette.accent.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private func bulletList(_ items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                HStack(alignment: .top, spacing: 8) {
                    Text("•")
                        .font(.system(size: 14))
                        .foregroundStyle(AppPalette.text)
                    Text(item)
                        .font(.system(size: 14))
                        .foregroundStyle(AppPalette.text)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private func tempC(_ v: Double?) -> String {
        guard let v else { return "—" }
        return formatNumber(v) + " °C"
    }

    private func tempK(_ v: Double?) -> String {
        guard let v else { return "—" }
        return String(format: "%.2f K", v + 273.15)
    }

    private func formatMass(_ m: Double) -> String { formatNumber(m) }

    private func formatNumber(_ v: Double) -> String {
        if v == v.rounded() {
            return String(Int(v))
        }
        let s = String(format: "%g", v)
        return s
    }
}

#Preview {
    ElementDetailView(element: ElementsData.all[0]) {}
        .frame(width: 780, height: 700)
}
