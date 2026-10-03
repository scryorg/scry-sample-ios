import SwiftUI

@main
struct KettleApp: App {
    var body: some Scene {
        WindowGroup {
            ScryLaunchRoot { // scry-hook
                RootView()
            } // scry-hook
        }
    }
}
