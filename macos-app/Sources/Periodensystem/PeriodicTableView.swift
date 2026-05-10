import SwiftUI

struct PeriodicTableView: View {
    @Binding var selected: Element?

    private let mainGrid: [String: Element]
    private let lanthanides: [Element]
    private let actinides: [Element]

    init(selected: Binding<Element?>) {
        self._selected = selected

        let all = ElementsData.all
        var map: [String: Element] = [:]
        for el in all where !el.category.isLanthanideOrActinide {
            map["\(el.row)-\(el.col)"] = el
        }
        self.mainGrid = map
        self.lanthanides = all.filter { $0.z >= 57 && $0.z <= 71 }.sorted { $0.z < $1.z }
        self.actinides = all.filter { $0.z >= 89 && $0.z <= 103 }.sorted { $0.z < $1.z }
    }

    var body: some View {
        VStack(spacing: 10) {
            Grid(horizontalSpacing: 4, verticalSpacing: 4) {
                ForEach(1...7, id: \.self) { row in
                    GridRow {
                        ForEach(1...18, id: \.self) { col in
                            cellFor(row: row, col: col)
                        }
                    }
                }
            }

            Text("Lanthanoide / Actinoide")
                .font(.system(size: 12))
                .foregroundStyle(AppPalette.muted)
                .padding(.top, 10)
                .padding(.bottom, 4)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(AppPalette.border)
                        .frame(height: 1)
                }

            Grid(horizontalSpacing: 4, verticalSpacing: 4) {
                GridRow {
                    ForEach(0..<3, id: \.self) { _ in EmptyCellView() }
                    ForEach(lanthanides) { el in
                        Button { selected = el } label: { ElementCellView(element: el) }
                            .buttonStyle(.plain)
                    }
                }
                GridRow {
                    ForEach(0..<3, id: \.self) { _ in EmptyCellView() }
                    ForEach(actinides) { el in
                        Button { selected = el } label: { ElementCellView(element: el) }
                            .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func cellFor(row: Int, col: Int) -> some View {
        if row == 6 && col == 3 {
            Button {
                selected = ElementsData.all.first { $0.z == 57 }
            } label: {
                PlaceholderCellView(
                    number: "57-71",
                    symbol: "La-Lu",
                    label: "Lanthanoide",
                    category: .lanthanide
                )
            }
            .buttonStyle(.plain)
        } else if row == 7 && col == 3 {
            Button {
                selected = ElementsData.all.first { $0.z == 89 }
            } label: {
                PlaceholderCellView(
                    number: "89-103",
                    symbol: "Ac-Lr",
                    label: "Actinoide",
                    category: .actinide
                )
            }
            .buttonStyle(.plain)
        } else if let el = mainGrid["\(row)-\(col)"] {
            Button { selected = el } label: { ElementCellView(element: el) }
                .buttonStyle(.plain)
        } else {
            EmptyCellView()
        }
    }
}
