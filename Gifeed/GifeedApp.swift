// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@main
struct GifeedApp: App {
  var body: some Scene {
    WindowGroup {
      MainTabBarView(store: Store(initialState: MainTabBar.State()) {
        MainTabBar()
      }).preferredColorScheme(.dark)
    }
  }
}
