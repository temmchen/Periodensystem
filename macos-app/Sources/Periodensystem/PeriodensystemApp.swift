import SwiftUI

@main
struct PeriodensystemApp: App {
    var body: some Scene {
        WindowGroup("Periodensystem der Elemente") {
            ContentView()
                .frame(minWidth: 1100, minHeight: 760)
        }
        .windowResizability(.contentMinSize)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
    }
}
