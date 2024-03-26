// @copyright Gifeed by TrevisXcode

import ComposableArchitecture
import SwiftUI

@main
struct GifeedApp: App {
  var body: some Scene {
    WindowGroup {
      FeedView(store: Store(initialState: Feed.State()) {
        Feed()
      }).preferredColorScheme(.dark)
    }
  }
}
