import SwiftUI

struct LegendView: View {
    private let categories: [ElementCategory] = [
        .alkali, .alkaline, .transition, .posttransition,
        .metalloid, .nonmetal, .halogen, .noblegas,
        .lanthanide, .actinide,
    ]

    var body: some View {
        FlowLayout(spacing: 8, lineSpacing: 6) {
            ForEach(categories, id: \.self) { cat in
                Text(cat.legendName)
                    .font(.system(size: 11, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(cat.color)
                    .foregroundStyle(AppPalette.cellInk)
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: 1100)
    }
}
