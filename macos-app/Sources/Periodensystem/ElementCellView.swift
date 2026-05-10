import SwiftUI

struct ElementCellView: View {
    let element: Element
    @State private var hovering = false

    var body: some View {
        CellSurface(color: element.category.color) {
            CellContent(
                number: "\(element.z)",
                symbol: element.symbol,
                label: element.nameDE
            )
        }
        .onHover { hovering = $0 }
        .scaleEffect(hovering ? 1.12 : 1.0)
        .shadow(color: .black.opacity(hovering ? 0.5 : 0),
                radius: hovering ? 8 : 0,
                x: 0, y: hovering ? 6 : 0)
        .zIndex(hovering ? 5 : 0)
        .animation(.easeOut(duration: 0.15), value: hovering)
    }
}

struct PlaceholderCellView: View {
    let number: String
    let symbol: String
    let label: String
    let category: ElementCategory
    @State private var hovering = false

    var body: some View {
        CellSurface(color: category.color) {
            CellContent(number: number, symbol: symbol, label: label)
        }
        .onHover { hovering = $0 }
        .scaleEffect(hovering ? 1.12 : 1.0)
        .shadow(color: .black.opacity(hovering ? 0.5 : 0),
                radius: hovering ? 8 : 0,
                x: 0, y: hovering ? 6 : 0)
        .zIndex(hovering ? 5 : 0)
        .animation(.easeOut(duration: 0.15), value: hovering)
    }
}

struct EmptyCellView: View {
    var body: some View {
        Color.clear
            .aspectRatio(1, contentMode: .fit)
    }
}

private struct CellSurface<Content: View>: View {
    let color: Color
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6).fill(color)
            content()
                .padding(2)
                .foregroundStyle(AppPalette.cellInk)
        }
        .aspectRatio(1, contentMode: .fit)
        .contentShape(RoundedRectangle(cornerRadius: 6))
    }
}

private struct CellContent: View {
    let number: String
    let symbol: String
    let label: String

    var body: some View {
        VStack(spacing: 1) {
            HStack {
                Text(number)
                    .font(.system(size: 9, weight: .semibold))
                    .opacity(0.85)
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            Text(symbol)
                .font(.system(size: 18, weight: .bold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(label)
                .font(.system(size: 8, weight: .semibold))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.top, 1)
            Spacer(minLength: 0)
        }
    }
}
