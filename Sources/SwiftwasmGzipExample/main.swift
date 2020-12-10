import TokamakDOM
import Foundation

struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("SwiftWasm Gzip Example") {
            ContentView()
        }
    }
}

// @main attribute is not supported in SwiftPM apps.
// See https://bugs.swift.org/browse/SR-12683 for more details.
TokamakApp.main()
