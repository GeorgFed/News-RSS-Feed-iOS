import SwiftUI

@main
struct NewsApp: App {
  @StateObject private var newsViewModel = NewsViewModel()

  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
      }
    }
  }
}
